from percol.finder import FinderMultiQueryRegex

percol.command.specify_finder(FinderMultiQueryRegex)

percol.import_keymap({
    "C-x" : lambda percol: percol.command.toggle_mark(),
    "C-i" : lambda percol: percol.command.toggle_mark_all(),

    "C-b" : lambda percol: percol.command.backward_char(),
    "C-f" : lambda percol: percol.command.forward_char(),
    "M-b" : lambda percol: percol.command.backward_word(),
    "M-f" : lambda percol: percol.command.forward_word(),
    "C-d" : lambda percol: percol.command.delete_forward_char(),
    "C-h" : lambda percol: percol.command.delete_backward_char(),
    "M-d" : lambda percol: percol.command.delete_forward_word(),
    "M-h" : lambda percol: percol.command.delete_backward_word(),
    "C-a" : lambda percol: percol.command.beginning_of_line(),
    "C-e" : lambda percol: percol.command.end_of_line(),
    "C-k" : lambda percol: percol.command.kill_end_of_line(),
    "C-y" : lambda percol: percol.command.yank(),
    "C-t" : lambda percol: percol.command.transpose_chars(),
    "C-n" : lambda percol: percol.command.select_next(),
    "C-p" : lambda percol: percol.command.select_previous(),

    "C-d" : lambda percol: percol.cancel(),
})
