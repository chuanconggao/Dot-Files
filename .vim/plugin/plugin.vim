scriptencoding utf-8

call yankstack#setup()

let g:ctrlp_map = ''
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 1000
let g:ctrlp_max_depth = 10
let g:ctrlp_mruf_max = &history
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_root_markers = ['makefile', 'build.xml', '.svn', '.git', '.hg', '.cvs']
"let g:ctrlp_show_hidden = 1

let g:NERDChristmasTree = 1
let g:NERDTreeChDirMode = 1
"let g:NERDTreeShowHidden = 1

let g:tagbar_sort = 0
let g:tagbar_usearrows = 1
let g:tagbar_iconchars = ['▸', '▾']

let g:syntastic_check_on_wq = 0

let g:rootmarkers = ['.git', 'makefile', 'build.xml']

let g:showmarks_marks = "abcdefghijklmnopqrstuvwxyz"

let g:vim_markdown_folding_disabled = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 5

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_filetype_blacklist = {}
let g:ycm_filetype_specific_completion_to_disable = {}
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1

let g:languagetool_jar = '/usr/local/Cellar/languagetool/latest/libexec/languagetool-commandline.jar'

let g:indent_guides_auto_colors = 0
