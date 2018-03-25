import os

import ranger.api
import ranger.core.linemode

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
