#!/usr/bin/env python3
"""
Written by Nathan Prziborowski
Github: https://github.com/prziborowski

This code is released under the terms of the Apache 2
http://www.apache.org/licenses/LICENSE-2.0.html

Simple example for watching events of a datacenter.

"""
import re
import sys
from pyVmomi import vim, vmodl
from pyVim.connect import SmartConnectNoSSL
from pyVim.task import WaitForTask
from samples.tools import cli

__author__ = 'prziborowski'


def setup_args():
    #parser = cli.build_arg_parser()
    parser = cli.Parser()
    parser.add_custom_argument('-d', '--datacenter',
                        help='Name of datacenter to search on. '
                             'Defaults to first.')
    parser.add_custom_argument('--events',
                        help="Comma-separated list of events to monitor",
                        required=True)
    #return cli.prompt_for_password(parser.parse_args())
    return parser.get_args()


def event_callback(event):
    print("Event %s at %s" % (type(event), event.createdTime))


def main():
    args = setup_args()
    si = SmartConnectNoSSL(host=args.host,
                           user=args.user,
                           pwd=args.password,
                           port=args.port)
    if args.datacenter:
        dc = get_dc(si, args.datacenter)
    else:
        dc = si.content.rootFolder.childEntity[0]

    ids = re.split('\s*,\s*', args.events)
    byTime = vim.event.EventFilterSpec.ByTime(beginTime=si.CurrentTime())
    byEntity = vim.event.EventFilterSpec.ByEntity(entity=dc, recursion='all')
    filterSpec = vim.event.EventFilterSpec(eventTypeId=ids, time=byTime, entity=byEntity)

    eventCollector = si.content.eventManager.CreateCollector(filterSpec)
    # Keep track of events that are seen as latestPage won't remove them
    # until they have gone out of view.
    seenEvents = set()

    try:
        with PcFilter(eventCollector, ['latestPage']) as pc:
            pc.wait() # Get all the current events from the past.
            while True:
               updt = pc.wait()
               if updt is not None:
                   latestPage = updt.filterSet[0].objectSet[0].changeSet[0].val
                   for event in latestPage:
                       if event.key not in seenEvents:
                           seenEvents.add(event.key)
                           event_callback(event)
    finally:
        eventCollector.Remove()


# Class to simplify the property collector usage.
# Call wait once to generate the initial properties. Subsequent calls will
# wait for updates.
class PcFilter(object):
    def __init__(self, obj, props):
        self.obj = obj
        self.pc = self._get_pc().CreatePropertyCollector()
        self.props = props
        self.pcFilter = None
        self.version = ''

    def __enter__(self):
        PC = vmodl.query.PropertyCollector
        filterSpec = PC.FilterSpec()
        objSpec = PC.ObjectSpec(obj=self.obj)
        filterSpec.objectSet.append(objSpec)
        propSet = PC.PropertySpec(all=False)
        propSet.type = type(self.obj)
        propSet.pathSet = self.props
        filterSpec.propSet = [propSet]
        self.pcFilter = self.pc.CreateFilter(filterSpec, False)
        return self

    def __exit__(self, *args):
        if self.pcFilter is not None:
            self.pcFilter.Destroy()
        if self.pc is not None:
            self.pc.Destroy()

    def wait(self, timeout=None):
        options = vmodl.query.PropertyCollector.WaitOptions()
        options.maxWaitSeconds = timeout
        update = self.pc.WaitForUpdatesEx(self.version, options)
        if update is not None:
            self.version = update.version
        return update

    def _get_si(self):
        return vim.ServiceInstance('ServiceInstance', stub=self.obj._stub)

    def _get_pc(self):
        return self._get_si().content.propertyCollector


if __name__ == '__main__':
    main()
