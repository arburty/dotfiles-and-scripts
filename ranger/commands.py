from __future__ import (absolute_import, division, print_function)

from collections import deque
import os
import re
import sys

from ranger.api.commands import Command
from ranger.ext.shell_escape import shell_escape
# from ranger.gui.ui import open_pager

# My cusomization: arburty
class save_sorted_files_buffer(Command):
    """:save_sorted_files_buffer

    Save the sorted file buffer to datadir/copy_sorted_files
    """
    copy_sorted_filename = 'copy_sorted_files'

    def execute(self):
        fname = self.fm.datapath(self.copy_sorted_filename)
        unwritable = IOError if sys.version_info[0] < 3 else OSError
        try:
            fobj = open(fname, 'w')
        except unwritable:
            return self.fm.notify("Cannot open %s" %
                                  (fname or self.copy_sorted_filename), bad=True)

        startfile=self.fm.thisfile.path
        # not being used currently
        # fobj.write(startfile + "\n")
        listoffiles = self.fm.thisdir.files
        filenum=0

        for o in listoffiles:
            filenum += 1
            if str(o.path) == startfile:
                break

        # fobj.write(listoffiles.index(startfile)) + "\n")
        fobj.write(str(filenum) + "\n")
        fobj.write("\n".join(fobj.path for fobj in listoffiles))
        fobj.close()
        return None

class linktops(Command):
    def execute(self):
        os.system("notify-send 'starting linktops'")
        os.system("setsid -f ~/shared_drive/laptop-backup/.sysctl/bin/linktops")


class save_torrent(Command):
    def execute(self):
        os.system("~/shared_drive/laptop-backup/.sysctl/bin/save_torrents "
                  + shell_escape(self.fm.thisdir.path))
        os.system("setsid -f ~/shared_drive/laptop-backup/.sysctl/bin/linktops")
        newdir = self.fm.thisdir.basename
        self.fm.tab_new("~/shared_drive/laptop-backup/.sysctl/Videos/Torrents/"
                        + newdir)

class deleteAmp(Command):
    def execute(self):
        if self.arg(1):
            amp = self.rest(1)
        else:
            amp = self.fm.thisfile.path
        self.fm.notify("running deleteAmp " + amp)
        os.system("notify-send 'deleting Amp'")
        os.system("setsid -f ~/shared_drive/laptop-backup/.sysctl/bin/deleteAmp " + amp)


class count_images(Command):
    def execute(self):
        # sys.path.insert(0, '/home/vladislav/shared_drive/laptop-backup/.sysctl/bin')
        # import count_images
        # totals = count_images.return_totals()
        
        if self.arg(1):
            dir = self.rest(1)
        self.fm.execute_console('shell -p /home/vladislav/shared_drive/laptop-backup/.sysctl/bin/count_images.py ' + dir)
