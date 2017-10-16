c = get_config()

c.TerminalInteractiveShell.confirm_exit = False
c.IPythonQtConsoleApp.confirm_exit = False

c.IPythonWidget.font_family = "Consolas"
c.IPythonWidget.font_size = 14

c.IPythonWidget.width = 160
c.IPythonWidget.height = 40

c.InteractiveShellApp.exec_lines = ["from __future__ import absolute_import, division, print_function, unicode_literals"]
