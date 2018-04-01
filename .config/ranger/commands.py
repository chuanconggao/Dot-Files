import subprocess

import ranger.api
import ranger.core.linemode
from ranger.api.commands import Command

from ranger.ext.human_readable import human_readable

@ranger.api.register_linemode
class FileNameLiteLinemode(ranger.core.linemode.LinemodeBase):
    name = "filename_lite"

    def filetitle(self, fobj, metadata):
        return fobj.relative_path


    def infostring(self, fobj, metadata):
        if fobj.is_directory:
            return ""

        return human_readable(fobj.size)


class j(Command):
    """
    :j <directory>

    Uses autojump to set the current directory.
    """

    def execute(self):
        directory = subprocess.check_output(
            ["autojump"] + self.rest(1).split()
        ).decode("utf-8").rstrip('\n')

        self.fm.execute_console("cd " + directory)
