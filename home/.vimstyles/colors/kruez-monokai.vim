" Inspired by https://github.com/erichdongubler/vim-sublime-monokai

" Initialisation

if !has('gui_running') && &t_Co < 256
  " Shim this out so code doesn't hard break -- users should notice if this
  " doesn't work.
  fun! g:KruezMonokaiHighlight(group, style)
  endf
  finish
endif

if !exists('g:kruezmonokai_gui_italic')
  let g:kruezmonokai_gui_italic = 1
endif

if !exists('g:kruezmonokai_term_italic')
  let g:kruezmonokai_term_italic = 0
endif

let g:kruezmonokai_termcolors = 256 " does not support 16 color term right now.

set background=dark
hi clear

if exists('syntax_on')
  syntax reset
endif

let colors_name = 'kruez-monokai'

fun! s:h(group, style)
  let s:ctermformat = 'NONE'
  let s:guiformat = 'NONE'
  if has_key(a:style, 'format')
	let s:ctermformat = a:style.format
	let s:guiformat = a:style.format
  endif
  if g:kruezmonokai_term_italic == 0
	let s:ctermformat = substitute(s:ctermformat, ',italic', '', '')
	let s:ctermformat = substitute(s:ctermformat, 'italic,', '', '')
	let s:ctermformat = substitute(s:ctermformat, 'italic', '', '')
  endif
  if g:kruezmonokai_gui_italic == 0
	let s:guiformat = substitute(s:guiformat, ',italic', '', '')
	let s:guiformat = substitute(s:guiformat, 'italic,', '', '')
	let s:guiformat = substitute(s:guiformat, 'italic', '', '')
  endif
  if g:kruezmonokai_termcolors == 16
	let l:ctermfg = (has_key(a:style, 'fg') ? a:style.fg.cterm16 : 'NONE')
	let l:ctermbg = (has_key(a:style, 'bg') ? a:style.bg.cterm16 : 'NONE')
  else
	let l:ctermfg = (has_key(a:style, 'fg') ? a:style.fg.cterm : 'NONE')
	let l:ctermbg = (has_key(a:style, 'bg') ? a:style.bg.cterm : 'NONE')
  end
  execute 'highlight' a:group
		\ 'guifg='   (has_key(a:style, 'fg')      ? a:style.fg.gui   : 'NONE')
		\ 'guibg='   (has_key(a:style, 'bg')      ? a:style.bg.gui   : 'NONE')
		\ 'guisp='   (has_key(a:style, 'sp')      ? a:style.sp.gui   : 'NONE')
		\ 'gui='     (!empty(s:guiformat) ? s:guiformat   : 'NONE')
		\ 'ctermfg=' . l:ctermfg
		\ 'ctermbg=' . l:ctermbg
		\ 'cterm='   (!empty(s:ctermformat) ? s:ctermformat   : 'NONE')
endfunction

" Expose the more complicated style setting via a global function
fun! g:KruezMonokaiHighlight(group, style)
  return s:h(a:group, a:style)
endfun

" Palette

" Convenience function to have a convenient script variable name and an
" namespaced global variable
fun! s:create_palette_color(color_name, color_data)
  exec 'let s:' . a:color_name . ' = a:color_data'
  exec 'let g:kruezmonokai_' . a:color_name . ' = a:color_data'
endf

call s:create_palette_color('brightwhite', { 'gui': '#FFFFFF', 'cterm': '231' })
call s:create_palette_color('white',       { 'gui': '#E8E8E3', 'cterm': '252' })
call s:create_palette_color('black',       { 'gui': '#1A1919', 'cterm': '234' })
call s:create_palette_color('lightblack',  { 'gui': '#2D2E27', 'cterm': '235' })
call s:create_palette_color('lightblack2', { 'gui': '#383a3e', 'cterm': '236' })
call s:create_palette_color('darkblack',   { 'gui': '#211F1C', 'cterm': '233' })
call s:create_palette_color('grey',        { 'gui': '#8F908A', 'cterm': '243' })
call s:create_palette_color('lightgrey',   { 'gui': '#575b61', 'cterm': '237' })
call s:create_palette_color('darkgrey',    { 'gui': '#64645e', 'cterm': '239' })
call s:create_palette_color('warmgrey',    { 'gui': '#75715E', 'cterm': '59'  })

call s:create_palette_color('pink',        { 'gui': '#F0444B', 'cterm': '203' })
call s:create_palette_color('green',       { 'gui': '#A1D24D', 'cterm': '148' })
call s:create_palette_color('aqua',        { 'gui': '#51CEFF', 'cterm': '81'  })
call s:create_palette_color('yellow',      { 'gui': '#CED075', 'cterm': '186' })
call s:create_palette_color('darkyellow',  { 'gui': '#878700', 'cterm': '100' })
call s:create_palette_color('orange',      { 'gui': '#F87109', 'cterm': '208' })
call s:create_palette_color('purple',      { 'gui': '#9466ED', 'cterm': '99'  })
call s:create_palette_color('red',         { 'gui': '#e73c50', 'cterm': '196' })
call s:create_palette_color('darkred',     { 'gui': '#5f0000', 'cterm': '52'  })

call s:create_palette_color('addfg',       { 'gui': '#d7ffaf', 'cterm': '193' })
call s:create_palette_color('addbg',       { 'gui': '#5f875f', 'cterm': '65'  })
call s:create_palette_color('delbg',       { 'gui': '#f75f5f', 'cterm': '167' })
call s:create_palette_color('changefg',    { 'gui': '#d7d7ff', 'cterm': '189' })
call s:create_palette_color('changebg',    { 'gui': '#5f5f87', 'cterm': '60'  })

" Expose the foreground colors of the Kruez palette as a bunch of
" highlighting groups. This lets us (and users!) get tab completion for the `hi
" link` command, and use more semantic names for the colors we want to assign
" to groups

call s:h('KruezBrightWhite', { 'fg': s:brightwhite  })
call s:h('KruezWhite',       { 'fg': s:white        })
call s:h('KruezBlack',       { 'fg': s:black        })
call s:h('KruezLightBlack',  { 'fg': s:lightblack   })
call s:h('KruezLightBlack2', { 'fg': s:lightblack2  })
call s:h('KruezDarkBlack',   { 'fg': s:darkblack    })
call s:h('KruezGrey',        { 'fg': s:grey         })
call s:h('KruezLightGrey',   { 'fg': s:lightgrey    })
call s:h('KruezDarkGrey',    { 'fg': s:darkgrey     })
call s:h('KruezWarmGrey',    { 'fg': s:warmgrey     })

call s:h('KruezPink',        { 'fg': s:pink         })
call s:h('KruezGreen',       { 'fg': s:green        })
call s:h('KruezAqua',        { 'fg': s:aqua         })
call s:h('KruezYellow',      { 'fg': s:yellow       })
call s:h('KruezOrange',      { 'fg': s:orange       })
call s:h('KruezPurple',      { 'fg': s:purple       })
call s:h('KruezRed',         { 'fg': s:red          })
call s:h('KruezDarkRed',     { 'fg': s:darkred      })

" Default highlight groups (see ':help highlight-default' or http://vimdoc.sourceforge.net/htmldoc/syntax.html#highlight-groups)

call s:h('ColorColumn',  {                      'bg': s:lightblack2                            })
hi! link Conceal KruezLightGrey
call s:h('CursorColumn', {                      'bg': s:lightblack2                            })
call s:h('CursorLine',   {                      'bg': s:lightblack2                            })
call s:h('CursorLineNr', { 'fg': s:orange,      'bg': s:lightblack                             })
call s:h('DiffAdd',      { 'fg': s:addfg,       'bg': s:addbg                                  })
call s:h('DiffChange',   { 'fg': s:changefg,    'bg': s:changebg                               })
call s:h('DiffDelete',   { 'fg': s:black,       'bg': s:delbg                                  })
call s:h('DiffText',     { 'fg': s:black,       'bg': s:aqua                                   })
hi! link Directory KruezAqua
call s:h('ErrorMsg',     { 'fg': s:black,       'bg': s:red,      'format': 'standout'         })
hi! link FoldColumn KruezDarkBlack
call s:h('Folded',       { 'fg': s:warmgrey,    'bg': s:darkblack                              })
call s:h('IncSearch',    {                                        'format': 'reverse,underline'})
call s:h('LineNr',       { 'fg': s:grey,        'bg': s:lightblack                             })
call s:h('MatchParen',   {                                        'format': 'underline'        })
hi! link ModeMsg KruezYellow
hi! link MoreMsg KruezYellow
hi! link NonText KruezLightGrey
call s:h('Normal',       { 'fg': s:white,       'bg': s:black                                  })
if has('nvim')
  call s:h('NormalFloat',{ 'fg': s:white,       'bg': s:black                                  })
end
call s:h('Pmenu',        { 'fg': s:lightblack,  'bg': s:white                                  })
call s:h('PmenuSbar',    {                                                                     })
call s:h('PmenuSel',     { 'fg': s:aqua,        'bg': s:black,    'format': 'reverse,bold'     })
call s:h('PmenuThumb',   { 'fg': s:lightblack,  'bg': s:grey                                   })
hi! link Question KruezYellow
call s:h('Search',       {                                        'format': 'reverse,underline'})
hi! link SignColumn LineNr
hi! link SpecialKey KruezLightBlack2
call s:h('SpellBad',     {                      'bg': s:darkred                                })
call s:h('SpellCap',     {                      'bg': s:darkyellow                             })
call s:h('SpellLocal',   {                      'bg': s:darkyellow                             })
call s:h('SpellRare',    {                      'bg': s:darkyellow                             })
call s:h('StatusLine',   { 'fg': s:warmgrey,    'bg': s:black,    'format': 'reverse'          })
call s:h('StatusLineNC', { 'fg': s:darkgrey,    'bg': s:warmgrey, 'format': 'reverse'          })
call s:h('TabLine',      { 'fg': s:white,       'bg': s:darkgrey                               })
call s:h('TabLineFill',  { 'fg': s:grey,        'bg': s:darkgrey                               })
call s:h('TabLineSel',   { 'fg': s:black,       'bg': s:white                                  })
hi! link Title KruezYellow
call s:h('VertSplit',    { 'fg': s:darkgrey,    'bg': s:darkblack                              })
call s:h('Visual',       {                      'bg': s:lightgrey                              })
hi! link WarningMsg KruezRed

" Generic Syntax Highlighting (see reference: 'NAMING CONVENTIONS' at http://vimdoc.sourceforge.net/htmldoc/syntax.html#group-name)

hi! link Comment      KruezWarmGrey
hi! link Constant     KruezPurple
hi! link String       KruezYellow
hi! link Character    KruezYellow
hi! link Number       KruezPurple
hi! link Boolean      KruezPurple
hi! link Float        KruezPurple
hi! link Identifier   KruezWhite
hi! link Function     KruezWhite
hi! link Type         KruezAqua
hi! link StorageClass KruezPink
hi! link Structure    KruezPink
hi! link Typedef      KruezAqua
hi! link Statement    KruezWhite
hi! link Conditional  KruezPink
hi! link Repeat       KruezPink
hi! link Label        KruezPink
hi! link Operator     KruezPink
hi! link Keyword      KruezPink
hi! link Exception    KruezPink
call s:h('CommentURL',    { 'fg': s:grey, 'format': 'italic' })

hi! link PreProc        KruezGreen
hi! link Include        KruezWhite
hi! link Define         KruezPink
hi! link Macro          KruezGreen
hi! link PreCondit      KruezWhite
hi! link Special        KruezPurple
hi! link SpecialChar    KruezPink
hi! link Tag            KruezGreen
hi! link Delimiter      KruezPink
hi! link SpecialComment KruezAqua
" call s:h('Debug'          {})
call s:h('Underlined',    { 'format': 'underline' })
" call s:h('Ignore',        {})
call s:h('Error',         { 'fg': s:red, 'bg': s:darkred })
hi! link Todo           Comment

" Some highlighting groups custom to the Kruez Monokai theme

call s:h('KruezType',   { 'fg': s:aqua, 'format': 'italic' })
call s:h('KruezContextParam',  { 'fg': s:orange, 'format': 'italic' })
hi! link KruezDocumentation KruezGrey
hi! link KruezFunctionCall KruezAqua
hi! link KruezUserAttribute KruezGrey

" Neovim LSP support

if has('nvim')
  call s:h('LspReferenceText',  { 'bg': s:darkgrey })
  call s:h('LspReferenceRead',  { 'bg': s:addbg })
  call s:h('LspReferenceWrite', { 'bg': s:changebg })

	" TODO: WIP. I haven't tried to get parity with NERDTree yet.
	hi! link NvimTreeFolderIcon Comment
	hi! link NvimTreeGitDeleted KruezRed
	hi! link NvimTreeGitDirty   KruezYellow
	hi! link NvimTreeGitMerge   KruezPink
	hi! link NvimTreeGitRenamed KruezOrange
	hi! link NvimTreeGitStaged  KruezGreen
endif

" Bash/POSIX shell

hi! link shConditional Conditional
hi! link shDerefOff    Normal
hi! link shDerefSimple KruezAqua
hi! link shDerefVar    KruezAqua
hi! link shFunctionKey KruezPink
hi! link shLoop        Keyword
hi! link shQuote       String
hi! link shSet         Keyword
hi! link shStatement   KruezPink
" XXX: Other known deficiencies:
"
" * Can't highlight POSIX builtins right because shStatement is later in the
"     highlight stack
" * Can't override shOption to be "normal" because it could be within a string
"     or substitution. It looks okay anyway. :)
" * shCommandSub can't be override for a similar reason to shOption
" * Boolean operators and subsequent commands don't have the right
"     highlighting

" Batch

hi! link dosbatchImplicit    Keyword
hi! link dosbatchLabel       Normal
" FIXME: This should have its own group, like KruezEscapedSequence
hi! link dosbatchSpecialChar KruezPurple
hi! link dosbatchSwitch      Normal
" FIXME: Variables don't have their own highlighting in Kruez
" hi! link dosbatchVariable    KruezAqua
" XXX: string highlight is used for echo commands, but Kruez doesn't
" highlight at all
" XXX: Kruez sets everything to the right of an assignment to be a string
" color, but Vim doesn't

" XXX: Create an extra flag for "nice" stuff
" hi! link dosbatchLabel       Tag
" hi! link dosbatchStatement   Keyword
" hi! link dosbatchSwitch      KruezPurple
" hi! link dosbatchVariable    KruezAqua

" C

hi! link cAnsiFunction     KruezFunctionCall
hi! link cDefine           KruezGreen
hi! link cFormat           Special
hi! link cInclude          KruezPink
hi! link cLabel            KruezPink
hi! link cSpecial          Special
hi! link cSpecialCharacter Special
hi! link cStatement        Keyword
hi! link cStorageClass     KruezPink
hi! link cStructure        KruezType
hi! link cType             KruezType
" XXX: Other known deficiencies:
"
" * There's no way to distinguish between function calls and
"     definitions/declarations. :( If you prefer both to be colored, then you
"     can use `hi! link cCustom <color>`.

" CMake

hi! link cmakeCommand                            KruezAqua
hi! link cmakeKWfind_package                     KruezContextParam
hi! link cmakeKWproject                          KruezContextParam
" XXX: Variation: I actually really like making this aqua.
hi! link cmakeVariableValue                      Normal

" pboettch/vim-cmake-syntax plugin
hi! link cmakeBracketArgument                           KruezAqua
hi! link cmakeKWExternalProject                         KruezContextParam
hi! link cmakeKWExternalProject                         KruezContextParam
hi! link cmakeKWadd_compile_definitions                 KruezContextParam
hi! link cmakeKWadd_compile_definitions                 KruezContextParam
hi! link cmakeKWadd_compile_options                     KruezContextParam
hi! link cmakeKWadd_compile_options                     KruezContextParam
hi! link cmakeKWadd_custom_command                      KruezContextParam
hi! link cmakeKWadd_custom_command                      KruezContextParam
hi! link cmakeKWadd_custom_target                       KruezContextParam
hi! link cmakeKWadd_custom_target                       KruezContextParam
hi! link cmakeKWadd_definitions                         KruezContextParam
hi! link cmakeKWadd_definitions                         KruezContextParam
hi! link cmakeKWadd_dependencies                        KruezContextParam
hi! link cmakeKWadd_dependencies                        KruezContextParam
hi! link cmakeKWadd_executable                          KruezContextParam
hi! link cmakeKWadd_executable                          KruezContextParam
hi! link cmakeKWadd_library                             KruezContextParam
hi! link cmakeKWadd_library                             KruezContextParam
hi! link cmakeKWadd_link_options                        KruezContextParam
hi! link cmakeKWadd_link_options                        KruezContextParam
hi! link cmakeKWadd_subdirectory                        KruezContextParam
hi! link cmakeKWadd_subdirectory                        KruezContextParam
hi! link cmakeKWadd_test                                KruezContextParam
hi! link cmakeKWadd_test                                KruezContextParam
hi! link cmakeKWbuild_command                           KruezContextParam
hi! link cmakeKWbuild_command                           KruezContextParam
hi! link cmakeKWcmake_host_system_information           KruezContextParam
hi! link cmakeKWcmake_host_system_information           KruezContextParam
hi! link cmakeKWcmake_minimum_required                  KruezContextParam
hi! link cmakeKWcmake_minimum_required                  KruezContextParam
hi! link cmakeKWcmake_parse_arguments                   KruezContextParam
hi! link cmakeKWcmake_parse_arguments                   KruezContextParam
hi! link cmakeKWcmake_policy                            KruezContextParam
hi! link cmakeKWcmake_policy                            KruezContextParam
hi! link cmakeKWconfigure_file                          KruezContextParam
hi! link cmakeKWconfigure_file                          KruezContextParam
hi! link cmakeKWconfigure_package_config_file           KruezContextParam
hi! link cmakeKWconfigure_package_config_file           KruezContextParam
hi! link cmakeKWconfigure_package_config_file_constants KruezContextParam
hi! link cmakeKWconfigure_package_config_file_constants KruezContextParam
hi! link cmakeKWcreate_test_sourcelist                  KruezContextParam
hi! link cmakeKWcreate_test_sourcelist                  KruezContextParam
hi! link cmakeKWctest_build                             KruezContextParam
hi! link cmakeKWctest_build                             KruezContextParam
hi! link cmakeKWctest_configure                         KruezContextParam
hi! link cmakeKWctest_configure                         KruezContextParam
hi! link cmakeKWctest_coverage                          KruezContextParam
hi! link cmakeKWctest_coverage                          KruezContextParam
hi! link cmakeKWctest_memcheck                          KruezContextParam
hi! link cmakeKWctest_memcheck                          KruezContextParam
hi! link cmakeKWctest_run_script                        KruezContextParam
hi! link cmakeKWctest_run_script                        KruezContextParam
hi! link cmakeKWctest_start                             KruezContextParam
hi! link cmakeKWctest_start                             KruezContextParam
hi! link cmakeKWctest_submit                            KruezContextParam
hi! link cmakeKWctest_submit                            KruezContextParam
hi! link cmakeKWctest_test                              KruezContextParam
hi! link cmakeKWctest_test                              KruezContextParam
hi! link cmakeKWctest_update                            KruezContextParam
hi! link cmakeKWctest_update                            KruezContextParam
hi! link cmakeKWctest_upload                            KruezContextParam
hi! link cmakeKWctest_upload                            KruezContextParam
hi! link cmakeKWdefine_property                         KruezContextParam
hi! link cmakeKWdefine_property                         KruezContextParam
hi! link cmakeKWenable_language                         KruezContextParam
hi! link cmakeKWenable_language                         KruezContextParam
hi! link cmakeKWenable_testing                          KruezContextParam
hi! link cmakeKWenable_testing                          KruezContextParam
hi! link cmakeKWexec_program                            KruezContextParam
hi! link cmakeKWexec_program                            KruezContextParam
hi! link cmakeKWexecute_process                         KruezContextParam
hi! link cmakeKWexecute_process                         KruezContextParam
hi! link cmakeKWexport                                  KruezContextParam
hi! link cmakeKWexport                                  KruezContextParam
hi! link cmakeKWexport_library_dependencies             KruezContextParam
hi! link cmakeKWexport_library_dependencies             KruezContextParam
hi! link cmakeKWfile                                    KruezContextParam
hi! link cmakeKWfile                                    KruezContextParam
hi! link cmakeKWfind_file                               KruezContextParam
hi! link cmakeKWfind_file                               KruezContextParam
hi! link cmakeKWfind_library                            KruezContextParam
hi! link cmakeKWfind_library                            KruezContextParam
hi! link cmakeKWfind_package                            KruezContextParam
hi! link cmakeKWfind_package                            KruezContextParam
hi! link cmakeKWfind_path                               KruezContextParam
hi! link cmakeKWfind_path                               KruezContextParam
hi! link cmakeKWfind_program                            KruezContextParam
hi! link cmakeKWfind_program                            KruezContextParam
hi! link cmakeKWfltk_wrap_ui                            KruezContextParam
hi! link cmakeKWfltk_wrap_ui                            KruezContextParam
hi! link cmakeKWforeach                                 KruezContextParam
hi! link cmakeKWforeach                                 KruezContextParam
hi! link cmakeKWfunction                                KruezContextParam
hi! link cmakeKWfunction                                KruezContextParam
hi! link cmakeKWget_cmake_property                      KruezContextParam
hi! link cmakeKWget_cmake_property                      KruezContextParam
hi! link cmakeKWget_directory_property                  KruezContextParam
hi! link cmakeKWget_directory_property                  KruezContextParam
hi! link cmakeKWget_filename_component                  KruezContextParam
hi! link cmakeKWget_filename_component                  KruezContextParam
hi! link cmakeKWget_property                            KruezContextParam
hi! link cmakeKWget_property                            KruezContextParam
hi! link cmakeKWget_source_file_property                KruezContextParam
hi! link cmakeKWget_source_file_property                KruezContextParam
hi! link cmakeKWget_target_property                     KruezContextParam
hi! link cmakeKWget_target_property                     KruezContextParam
hi! link cmakeKWget_test_property                       KruezContextParam
hi! link cmakeKWget_test_property                       KruezContextParam
hi! link cmakeKWif                                      KruezContextParam
hi! link cmakeKWif                                      KruezContextParam
hi! link cmakeKWinclude                                 KruezContextParam
hi! link cmakeKWinclude                                 KruezContextParam
hi! link cmakeKWinclude_directories                     KruezContextParam
hi! link cmakeKWinclude_directories                     KruezContextParam
hi! link cmakeKWinclude_external_msproject              KruezContextParam
hi! link cmakeKWinclude_external_msproject              KruezContextParam
hi! link cmakeKWinclude_guard                           KruezContextParam
hi! link cmakeKWinclude_guard                           KruezContextParam
hi! link cmakeKWinstall                                 KruezContextParam
hi! link cmakeKWinstall                                 KruezContextParam
hi! link cmakeKWinstall_files                           KruezContextParam
hi! link cmakeKWinstall_files                           KruezContextParam
hi! link cmakeKWinstall_programs                        KruezContextParam
hi! link cmakeKWinstall_programs                        KruezContextParam
hi! link cmakeKWinstall_targets                         KruezContextParam
hi! link cmakeKWinstall_targets                         KruezContextParam
hi! link cmakeKWlink_directories                        KruezContextParam
hi! link cmakeKWlink_directories                        KruezContextParam
hi! link cmakeKWlist                                    KruezContextParam
hi! link cmakeKWlist                                    KruezContextParam
hi! link cmakeKWload_cache                              KruezContextParam
hi! link cmakeKWload_cache                              KruezContextParam
hi! link cmakeKWload_command                            KruezContextParam
hi! link cmakeKWload_command                            KruezContextParam
hi! link cmakeKWmacro                                   KruezContextParam
hi! link cmakeKWmacro                                   KruezContextParam
hi! link cmakeKWmark_as_advanced                        KruezContextParam
hi! link cmakeKWmark_as_advanced                        KruezContextParam
hi! link cmakeKWmath                                    KruezContextParam
hi! link cmakeKWmath                                    KruezContextParam
hi! link cmakeKWmessage                                 KruezContextParam
hi! link cmakeKWmessage                                 KruezContextParam
hi! link cmakeKWoption                                  KruezContextParam
hi! link cmakeKWoption                                  KruezContextParam
hi! link cmakeKWproject                                 KruezContextParam
hi! link cmakeKWproject                                 KruezContextParam
hi! link cmakeKWqt_wrap_cpp                             KruezContextParam
hi! link cmakeKWqt_wrap_cpp                             KruezContextParam
hi! link cmakeKWqt_wrap_ui                              KruezContextParam
hi! link cmakeKWqt_wrap_ui                              KruezContextParam
hi! link cmakeKWremove                                  KruezContextParam
hi! link cmakeKWremove                                  KruezContextParam
hi! link cmakeKWseparate_arguments                      KruezContextParam
hi! link cmakeKWseparate_arguments                      KruezContextParam
hi! link cmakeKWset                                     KruezContextParam
hi! link cmakeKWset                                     KruezContextParam
hi! link cmakeKWset_directory_properties                KruezContextParam
hi! link cmakeKWset_directory_properties                KruezContextParam
hi! link cmakeKWset_property                            KruezContextParam
hi! link cmakeKWset_property                            KruezContextParam
hi! link cmakeKWset_source_files_properties             KruezContextParam
hi! link cmakeKWset_source_files_properties             KruezContextParam
hi! link cmakeKWset_target_properties                   KruezContextParam
hi! link cmakeKWset_target_properties                   KruezContextParam
hi! link cmakeKWset_target_properties                   KruezContextParam
hi! link cmakeKWset_tests_properties                    KruezContextParam
hi! link cmakeKWset_tests_properties                    KruezContextParam
hi! link cmakeKWsource_group                            KruezContextParam
hi! link cmakeKWsource_group                            KruezContextParam
hi! link cmakeKWstring                                  KruezContextParam
hi! link cmakeKWstring                                  KruezContextParam
hi! link cmakeKWsubdirs                                 KruezContextParam
hi! link cmakeKWsubdirs                                 KruezContextParam
hi! link cmakeKWtarget_compile_definitions              KruezContextParam
hi! link cmakeKWtarget_compile_definitions              KruezContextParam
hi! link cmakeKWtarget_compile_features                 KruezContextParam
hi! link cmakeKWtarget_compile_features                 KruezContextParam
hi! link cmakeKWtarget_compile_options                  KruezContextParam
hi! link cmakeKWtarget_compile_options                  KruezContextParam
hi! link cmakeKWtarget_include_directories              KruezContextParam
hi! link cmakeKWtarget_include_directories              KruezContextParam
hi! link cmakeKWtarget_link_directories                 KruezContextParam
hi! link cmakeKWtarget_link_directories                 KruezContextParam
hi! link cmakeKWtarget_link_libraries                   KruezContextParam
hi! link cmakeKWtarget_link_libraries                   KruezContextParam
hi! link cmakeKWtarget_link_options                     KruezContextParam
hi! link cmakeKWtarget_link_options                     KruezContextParam
hi! link cmakeKWtarget_sources                          KruezContextParam
hi! link cmakeKWtarget_sources                          KruezContextParam
hi! link cmakeKWtry_compile                             KruezContextParam
hi! link cmakeKWtry_compile                             KruezContextParam
hi! link cmakeKWtry_run                                 KruezContextParam
hi! link cmakeKWtry_run                                 KruezContextParam
hi! link cmakeKWunset                                   KruezContextParam
hi! link cmakeKWunset                                   KruezContextParam
hi! link cmakeKWuse_mangled_mesa                        KruezContextParam
hi! link cmakeKWuse_mangled_mesa                        KruezContextParam
hi! link cmakeKWvariable_requires                       KruezContextParam
hi! link cmakeKWvariable_requires                       KruezContextParam
hi! link cmakeKWvariable_watch                          KruezContextParam
hi! link cmakeKWvariable_watch                          KruezContextParam
hi! link cmakeKWwrite_basic_package_version_file        KruezContextParam
hi! link cmakeKWwrite_basic_package_version_file        KruezContextParam
hi! link cmakeKWwrite_basic_package_version_file        KruezContextParam
hi! link cmakeKWwrite_file                              KruezContextParam
hi! link cmakeKWwrite_file                              KruezContextParam
hi! link cmakeProperty                                  KruezContextParam

" XXX: Other known deficiencies:
" * Some special args like `IMPORTED_TARGET` aren't recognized in Vim, but
"     Kruez's `CMake` package recognizes them.

" CSS

hi! link cssAttr              KruezAqua
hi! link cssAttributeSelector Tag
" XXX: Not sure about this one; it has issues with the following:
"   - calc
"   - colors
hi! link cssAttrRegion      Normal
hi! link cssBraces          Normal
hi! link cssClassName       Tag
hi! link cssColor           Constant
hi! link cssFunctionName    KruezFunctionCall
hi! link cssIdentifier      Tag
hi! link cssPositioningAttr KruezAqua
hi! link cssProp            KruezAqua
" XXX: Variation: might be better as pink, actually
hi! link cssPseudoClassId   Normal
hi! link cssSelectorOp      Normal
hi! link cssStyle           cssAttr
hi! link cssTagName         Keyword
" TODO: Find a way to distinguish unit decorators from color hash
hi! link cssUnitDecorators  SpecialChar
hi! link cssURL             String
hi! link cssValueLength     Constant

" C++

" XXX: This is imperfect, as this highlights the expression for the `#if`s
" too.
hi! link cCppOutWrapper  Keyword
hi! link cppStatement    Keyword
" XXX: This is too inclusive of the `namespace` keyword
hi! link cppStructure    KruezType
hi! link cppSTLException KruezType
hi! link cppSTLfunction  KruezFunctionCall
" XXX: There may be no special highlighting here in Kruez itself
hi! link cppSTLios       KruezAqua
" XXX: There may be no special highlighting here in Kruez itself
hi! link cppSTLnamespace KruezPurple
hi! link cppType         KruezType
" XXX: Other known deficiencies:
"
" * There's no way to distinguish between function calls and
"     definitions/declarations. :( If you prefer both to be colored, then you
"     can use `hi! link cCustom <color>`.

" C#

hi! link csClass                KruezType
hi! link csContextualStatement  Keyword
hi! link csIface                KruezType
hi! link csMethodTag            KruezType
hi! link csPreCondit            Keyword
hi! link csTypeDecleration      KruezType
hi! link csType                 KruezType
hi! link csUnspecifiedStatement Keyword
hi! link csXmlTag               xmlTagName
hi! link csXmlComment           KruezDocumentation
" XXX: Other known deficiencies:
"
" *  Need some local links for XML getting set to the right color
" *  Operators aren't red in Vim, but are in Kruez.
" *  Function arguments aren't distinguished with their own highlight group
" *  `namespace` is a type in Kruez's highlighting, but is a `csStorage` in
"     Vim
" *  No function call groups exist in Vim.
" *  Region highlighting has no way to distinguish between region
"     preprocess keyword and region name.

" D

hi! link dExternal Keyword

" `diff` patch files

hi! link diffAdded     KruezGreen
hi! link diffFile      KruezWarmGrey
hi! link diffIndexLine KruezWarmGrey
hi! link diffLine      KruezWarmGrey
hi! link diffRemoved   KruezPink
hi! link diffSubname   KruezWarmGrey

" eRuby

" call s:h('erubyDelimiter',              {})
hi! link erubyRailsMethod KruezAqua

" Git

hi! link gitrebaseCommit  Comment
hi! link gitrebaseDrop    Error
hi! link gitrebaseEdit    Keyword
hi! link gitrebaseExec    Keyword
hi! link gitrebaseFixup   Keyword
" FIXME: Make this cooler in extensions!
hi! link gitrebaseHash    Comment
hi! link gitrebasePick    Keyword
hi! link gitrebaseReword  Keyword
hi! link gitrebaseSquash  Keyword
hi! link gitrebaseSummary String
" XXX: Note that highlighting inside the always-present help from Git in
" comments is not available in vim's current highlighting version.
" Variation: it's actually kinda nice to give each of these different colors
" like vanilla Vim does.

" vim-gitgutter

hi! link GitGutterAdd          KruezGreen
hi! link GitGutterChange       KruezYellow
hi! link GitGutterDelete       KruezPink
hi! link GitGutterChangeDelete KruezOrange

" GraphViz
" Variation: I actually like to keep these as Keyword, but Kruez does this
" differently.
hi! link dotBraceEncl Normal
hi! link dotBrackEncl Normal
" XXX: This colors way more stuff than Kruez does, but otherwise we'd miss
" out on operator highlights like with equals signs in attribute value
" definitions.
hi! link dotKeyChar Keyword
hi! link dotKeyword KruezType
" XXX: Other known deficiencies:
"
" * `graph` keyword isn't correctly classified into a keyword, Kruez does.
"     This can be fixed with `syn keyword dotKeyword graph`.
" * Neither Kruez nor Vim highlight `--` in undirected graphs.
" * Kruez doesn't treat semicolons as a keyword here, Vim does.
" * Vim doesn't distinctly identify declarations like `digraph *blah* { ... }`.
" * Vim doesn't have a group for escape chars (i.e., for `label` values).

" Go

hi! link goArgumentName      KruezContextParam
hi! link goDeclType          KruezType
hi! link goDeclaration       KruezType
hi! link goField             Identifier
hi! link goFunction          Tag
hi! link goFunctionCall      KruezFunctionCall
" Variation: It's not a bad idea to highlight these separately. Maybe using
" `PreProc` and `Special` like in vanilla `vim-go` upstream isn't a bad idea.
hi! link goGenerate          Comment
hi! link goGenerateVariables Comment
" Variation: It's nice to have builtins highlighted specially, though Kruez
" doesn't do this. I would use `Special` here.
hi! link goExtraType         Identifier
hi! link goImport            Keyword
hi! link goPackage           Keyword
hi! link goReceiverVar       KruezContextParam
hi! link goStatement         Keyword
hi! link goType              KruezType
" Variation: I like this better as `KruezType`, since it has symmetry with
" `goType`.
hi! link goTypeConstructor   Identifier
hi! link goTypeDecl          KruezType
hi! link goTypeName          Tag
hi! link goVarAssign         Normal
hi! link goVarDefs           Normal

" HTML
" This partially depends on XML -- make sure that groups in XML don't
" adversely affect this!

" XXX: This doesn't exclude things like colons like Kruez does
" FIXME: For some reason this is excluding a "key" attribute
hi! link htmlArg            Tag
" Variation: This is an interesting idea for
hi! link htmlLink           Normal
hi! link htmlSpecialTagName htmlTagName
hi! link htmlSpecialChar    Special
hi! link htmlTagName        Keyword

" Java
" Java Syntax options: https://github.com/vim/vim/blob/master/runtime/syntax/java.vim

"   Common groups
hi! link javaAnnotation       KruezAqua
hi! link javaAssert           KruezFunctionCall
hi! link javaClassDecl        KruezType
hi! link javaConditional      Keyword
hi! link javaExceptions       Keyword
hi! link javaExternal         Keyword
hi! link javaRepeat           Keyword
hi! link javaSpecialChar      Special
hi! link javaStatement        Keyword
hi! link javaType             KruezType
hi! link javaTypedef          KruezContextParam
hi! link javaUserLabel        Normal
hi! link javaUserLabelRef     Normal
" XXX: Other known deficiencies:
"
" * There's currently no highlight group for user-defined type names. Weird.
" * `javaClassDecl`, which is the stuff that can go around a class name in a
"     class declaration, doesn't distinguish like Kruez does between the `class`
"     keyword and the `extends`/`implements` keywords.
" * There's a LOT of operators that don't have a good group. :(
" * No nice highlight groups exist for lambdas yet. Mainline `vim` has one,
"     but it highlights the entire span of the lambda.


"   Mainline vim distro

" Variation: I actually like keeping this a separate color -- it's kind of
" nice.
" XXX: Kruez distinguishes between @param names and other tags, but this
" doesn't.
hi! link javaCommentTitle     KruezDocumentation
hi! link javaDocParam         KruezAqua
hi! link javaDocTags          Keyword
hi! link javaFuncDef          Tag
hi! link javaC_JavaLang       KruezType
hi! link javaE_JavaLang       KruezType
hi! link javaR_JavaLang       KruezType
hi! link javaX_JavaLang       KruezType
hi! link javaVarArg           Keyword
" XXX: Other known deficiencies (mainline vim):
"
" * javaFuncDef is way too inclusive -- even the args and its parens are
"     highlighted!
" * java*_JavaLang isn't really up-to-date.

"   vim-java

hi! link javaDeclType         KruezType
" XXX: Currently unable to distinguish function calls from function definitions.
hi! link javaFunction         KruezAqua
hi! link javaMapType          KruezType
" XXX: This isn't a builtin...don't other languages use italics for types?
hi! link javaNonPrimitiveType KruezType

call s:h('jpropertiesIdentifier', { 'fg': s:pink })

" JavaScript

hi! link jsArgsObj        KruezAqua
hi! link jsArrowFunction  KruezPink
hi! link jsBuiltins       KruezFunctionCall
hi! link jsCatch          Keyword
hi! link jsConditional    Keyword
call s:h('jsDocTags',       { 'fg': s:aqua, 'format': 'italic' })
hi! link jsException      Keyword
" Variation: It's actually nice to get this italicized, to me
hi! link jsExceptions     Type
hi! link jsExport         Keyword
hi! link jsFinally        Keyword
hi! link jsFrom           Keyword
call s:h('jsFuncArgRest',   { 'fg': s:purple, 'format': 'italic' })
hi! link jsFuncArgs       KruezContextParam
hi! link jsFuncCall       KruezFunctionCall
hi! link jsFuncName       Tag
hi! link jsFunction       KruezType
hi! link jsFunctionKey    Tag
" FIXME: FutureKeys includes a bit too much. It had some type names, which should be aqua, but most of the keywords that might actually get used would be pink (keywords like public, abstract).
hi! link jsFutureKeys     Keyword
call s:h('jsGlobalObjects', { 'fg': s:aqua, 'format': 'italic' })
hi! link jsImport         Keyword
hi! link jsModuleAs       Keyword
hi! link jsModuleAsterisk Keyword
hi! link jsNan            Constant
hi! link jsNull           Constant
hi! link jsObjectFuncName Tag
hi! link jsPrototype      KruezAqua
" Variation: Technically this is extra from Kruez, but it looks nice.
hi! link jsRepeat         Keyword
hi! link jsReturn         Keyword
hi! link jsStatement      Keyword
hi! link jsStatic         jsStorageClass
hi! link jsStorageClass   KruezType
hi! link jsSuper          KruezContextParam
hi! link jsThis           KruezContextParam
hi! link jsTry            Keyword
hi! link jsUndefined      Constant

" JSON

hi! link jsonKeyword Identifier

" LESS

hi! link lessVariable Tag

" Makefile

hi! link makeCommands    Normal
hi! link makeCmdNextLine Normal

" NERDTree

hi! link NERDTreeBookmarkName    KruezYellow
hi! link NERDTreeBookmarksHeader KruezPink
hi! link NERDTreeBookmarksLeader KruezBlack
hi! link NERDTreeCWD             KruezPink
hi! link NERDTreeClosable        KruezYellow
hi! link NERDTreeDir             KruezYellow
hi! link NERDTreeDirSlash        KruezGrey
hi! link NERDTreeFlags           KruezDarkGrey
hi! link NERDTreeHelp            KruezYellow
hi! link NERDTreeOpenable        KruezYellow
hi! link NERDTreeUp              KruezWhite

" NERDTree Git

hi! link NERDTreeGitStatusModified KruezOrange
hi! link NERDTreeGitStatusRenamed KruezOrange
hi! link NERDTreeGitStatusUntracked KruezGreen

" PHP

" Variation: It's actually a cool idea to style these to assist reading.
hi! link phpClass           Tag
call s:h('phpClassExtends', { 'fg': s:green, 'format': 'italic' })
hi! link phpComment         Comment
hi! link phpCommentStar     KruezDocumentation
hi! link phpCommentTitle    KruezDocumentation
hi! link phpDocComment      KruezDocumentation
hi! link phpDocIdentifier   KruezDocumentation
hi! link phpDocParam        KruezDocumentation
hi! link phpDocTags         Keyword
" Variation: It'd be nice to make these a different color, but there's SO MANY
" THINGS that this applies to!
hi! link phpKeyword         Keyword
" Variation: I actually like linking this against `Keyword`.
hi! link phpMemberSelector  Identifier
hi! link phpNullValue       Special
hi! link phpParent          Normal
call s:h('phpStaticClasses', { 'fg': s:aqua, 'format': 'italic' })
" Variation: I actually like linking this against `Keyword` instead.
hi! link phpVarSelector     Identifier
" XXX: Other known deficiencies:
"
" * Links in doc comments are highlighted aqua in Kruez, but there's no
"     distinguishing right now with php.vim.
" * `phpKeyword` is used as a blanket group for several things that Kruez
"     distinguishes right now. For example:
"     * `echo` should be aqua
"     * `function` should be a `KruezType`
"     * `return` should be a `Keyword`
"     * `class` should be aqua and italic (maybe `KruezType`?)
"
"     ... but these are all listed as a `Keyword` right now.
" * Local args don't have their own highlighting group yet in `php.vim`
" * Some doctags don't get highlight like in Kruez because Kruez is
"     weirdly inconsistent with them.
" * The PHP delimiter uses `Delimiter`, which was set to be pink for other
"     reasons. Kruez shows them as white, though.

" Python

" This configuration assumed python-mode
hi! link pythonBuiltinFunc KruezFunctionCall
hi! link pythonConditional Conditional
hi! link pythonException   Keyword
hi! link pythonFunction    Tag
hi! link pythonInclude     Keyword
hi! link pythonLambdaExpr  KruezType
" XXX: def parens are, for some reason, included in this group.
hi! link pythonParam       KruezContextParam
" XXX: pythonStatement covers a bit too much...unfortunately, this means that
" some keywords, like `def`, can't be highlighted like in Kruez yet.
hi! link pythonStatement   Keyword
" XXX: Other known deficiencies:
"
" * Python special regexp sequences aren't highlighted. :\
" * Function cals aren't highlighted like they are in Kruez.
" * Keyword args aren't highlighted at all like in Kruez.
"
" Most of the above really are just because I haven't found a syntax that
" supports these distinctions yet.

" QuickScope plugin

call s:h('QuickScopePrimary',   { 'bg': s:lightgrey, 'fg': s:black,     'format': 'underline' })
call s:h('QuickScopeSecondary', { 'bg': s:black,     'fg': s:lightgrey, 'format': 'underline' })

" Ruby

" call s:h('rubyInterpolationDelimiter',  {})
" call s:h('rubyInstanceVariable',        {})
" call s:h('rubyGlobalVariable',          {})
" call s:h('rubyClassVariable',           {})
" call s:h('rubyPseudoVariable',          {})
hi! link rubyFunction                 KruezGreen
hi! link rubyStringDelimiter          KruezYellow
hi! link rubyRegexp                   KruezYellow
hi! link rubyRegexpDelimiter          KruezYellow
hi! link rubySymbol                   KruezPurple
hi! link rubyEscape                   KruezPurple
hi! link rubyInclude                  KruezPink
hi! link rubyOperator                 Operator
hi! link rubyControl                  KruezPink
hi! link rubyClass                    KruezPink
hi! link rubyDefine                   KruezPink
hi! link rubyException                KruezPink
hi! link rubyRailsARAssociationMethod KruezOrange
hi! link rubyRailsARMethod            KruezOrange
hi! link rubyRailsRenderMethod        KruezOrange
hi! link rubyRailsMethod              KruezOrange
hi! link rubyConstant                 KruezAqua
hi! link rubyBlockArgument            KruezContextParam
hi! link rubyBlockParameter           KruezContextParam

" Rust

hi! link rustAttribute      KruezGrey
hi! link rustCommentLineDoc KruezDocumentation
hi! link rustConditional    Conditional
hi! link rustDerive         KruezGrey
hi! link rustDeriveTrait    KruezGrey
" Variation: I like making these Special
hi! link rustEnumVariant    KruezType
hi! link rustFuncCall       KruezFunctionCall
hi! link rustFuncName       Tag
hi! link rustIdentifier     Tag
" Variation: I actually like making these Special too
hi! link rustLifetime       Keyword
hi! link rustMacro          KruezFunctionCall
hi! link rustModPathSep     Normal
hi! link rustQuestionMark   Keyword
hi! link rustRepeat         Keyword
hi! link rustSelf           KruezContextParam
" XXX: Other known deficiencies:
"
" * In Kruez, `fn` and `let` keywords are highlighted with italicized aqua,
"     but Vim lumps them with all other keywords
" * Crate names after `extern crate` are included in `rustIdentifier`, which
"     is technically more inclusive than Kruez's definition group but not so
"     bad I don't think it's an okay default.
" * Kruez does NOT have the `rustEnumVariant` distinction, which is actually
"     a really nice feature.
" * No `fn`/lambda param highlighting is available in Vim like in Kruez
"     here. :(
" * `rust.vim` doesn't highlight typical attributes like in Kruez. Kruez
"     makes this fairly nice, though I prefer to just make them look like doc
"     comments.

" SASS

hi! link sassAmpersand    Operator
hi! link sassClass        Tag
hi! link sassCssAttribute KruezAqua
hi! link sassInclude      Keyword
" FIXME: No distinction between mixin definition and call
hi! link sassMixinName    KruezAqua
hi! link sassMixing       Keyword
hi! link sassProperty     KruezAqua
hi! link sassSelectorOp   Operator
hi! link sassVariable     Identifier

" Scala
" XXX: This highlights the arroba (`@`) of the annotation too, but Kruez
" distinguishes the arroba with pink.
hi! link scalaAnnotation             KruezAqua
hi! link scalaCapitalWord            KruezAqua
hi! link scalaCaseFollowing          KruezContextParam
hi! link scalaEscapedChar            Special
hi! link scalaExternal               Keyword
hi! link scalaInstanceDeclaration    Tag
" XXX: This is a bit too inclusive compared to Kruez, since it also
" highlights the quotes themselves.
hi! link scalaInterpolationBrackets  KruezAqua
hi! link scalaKeywordModifier        Keyword
" Variation: I actually prefer these to be `Normal`.
hi! link scalaNameDefinition         Tag
" TODO: Is this too inclusive?
hi! link scalaSpecial                Keyword
hi! link scalaSquareBracketsBrackets Normal
" Variation: This isn't perfect, because it encompasses brackets right now.
hi! link scalaTypeDeclaration        KruezType
" XXX: Other known deficiencies:
"
" * `scalaCapitalWord` is a silly notion. That is all.
" * `scalaNumber` seems more inclusive (erroneously, from what I can tell)
"     than Kruez's number highlights.
" * Function and lambda params don't have a highlight group in vanilla Vim.
"    :(
" * Kruez distinguishes between groups of keywords, i.e., `case class`, from
"     things like `extends`. Vim's vanilla syntax currently doesn't.
" * Kruez highlights some operators pink and others it doesn't, i.e., it
"     DOES do `=` but not parents, brackets
" * Interestingly, arrow notation is highlighted differently for between case
"     matches (pink) and lambdas (blue).

" SQL

hi! link Quote        String
hi! link sqlFunction  KruezFunctionCall
hi! link sqlKeyword   Keyword
hi! link sqlStatement Keyword

" Syntastic

hi! link SyntasticErrorSign Error
call s:h('SyntasticWarningSign',    { 'fg': s:lightblack, 'bg': s:orange })

" Tagbar

hi! link TagbarFoldIcon            KruezPurple
hi! link TagbarHelp                Comment
hi! link TagbarKind                Keyword
hi! link TagbarNestedKind          Keyword
hi! link TagbarScope               Tag
hi! link TagbarSignature           Comment
hi! link TagbarVisibilityPrivate   KruezPink
hi! link TagbarVisibilityProtected KruezYellow
hi! link TagbarVisibilityPublic    KruezGreen

" TypeScript

" Why is this `Keyword` by default? Who knows?
hi! link typescriptEndColons              Normal
" XXX: This is too inclusive -- I expected this to just be the types, but it
" includes the `throw` keyword too.
hi! link typescriptExceptions             KruezType
hi! link typescriptFuncKeyword            KruezType
hi! link typescriptIdentifier             KruezContextParam
" Variation: I far prefer to let this be `Normal`...
hi! link typescriptInterpolation          String
" ...and have this be `Special`.
hi! link typescriptInterpolationDelimiter String
hi! link typescriptLogicSymbols           Keyword
" Why is this `Keyword` by default? Who knows?
hi! link typescriptParens                 Normal
" Variation: I prefer to make this `Special.`, since I use the value way more
" than `null` as a type. Kruez distinguishes, it'd be nice if we could too.
hi! link typescriptNull                   Special
hi! link typescriptStatement              Keyword
hi! link typescriptType                   KruezType

" XXX: Other deficiencies:
" * `typescriptReserved` doesn't allow some distinctions Kruez does:
"     * globs in imports
"     * `Tag` for things that are definitely declarations/definitions
"     * Browser context params like `console`
"     * Common functions like `console.debug`; I actually don't care about
"         these, but Kruez does.
"     * `is` keyword

" VimL

hi! link vimCommand       Keyword
" Variation: Interesting how this could vary...
hi! link vimCommentTitle  Comment
hi! link vimEnvvar        KruezAqua
hi! link vimFBVar         KruezWhite
hi! link vimFuncName      KruezAqua
hi! link vimFuncNameTag   KruezAqua
hi! link vimFunction      KruezGreen
hi! link vimFuncVar       KruezContextParam
hi! link vimHiGroup       Identifier
hi! link vimIsCommand     KruezAqua
hi! link vimMapModKey     KruezAqua
hi! link vimMapRhs        KruezYellow
hi! link vimNotation      KruezAqua
hi! link vimOption        KruezAqua
hi! link vimParenSep      KruezWhite
hi! link vimScriptFuncTag KruezPink
hi! link vimSet           Keyword
hi! link vimSetEqual      Operator
hi! link vimUserFunc      KruezAqua
hi! link vimVar           KruezWhite

" XML

hi! link xmlArg             Tag
hi! link xmlAttrib          Tag
" XXX: This highlight the brackets and end slash too...which we don't want.
hi! link xmlEndTag          Keyword
" Variation: I actually liked it when this was faded.
hi! link xmlProcessingDelim Normal
hi! link xmlTagName         Keyword

" YAML

hi! link yamlBlockCollectionItemStart Normal
hi! link yamlBlockMappingKey          Keyword
hi! link yamlEscape                   Special
" Variation: I kind of like keeping these Special
hi! link yamlFlowIndicator            Normal
hi! link yamlFlowMappingKey           Keyword
hi! link yamlKeyValueDelimiter        Normal
hi! link yamlPlainScalar              String
" XXX: Other known deficiencies:
"
" A good place to see these in action is: http://www.yaml.org/start.html
" * "yes"/"no" values are actually not recognized as yamlBool groups in Vim.
" * Literal/folded block scalars don't have their own group right now in Vim.
" * yamlInteger gets applied to leading numbers in literal/folded block
"     scalars in Vim.
" * References aren't handled at all by Vim, it seems.
" * Vim incorrectly highlights for comments after a scalar value has started.
"
" Other noted deficiencies when using YAML to manually analyze binary files:
"
" * Hex literals as map keys are highlighted in Kruez, not in Vim.
" * Kruez is more permissive about what it highlights for keys, but Kruez
"     may reject them as invalid; i.e., "???" (minus quotes)

" zsh

" Variation: I actually like making these aqua.
hi! link zshDeref    Normal
hi! link zshFunction Tag
" XXX: This isn't awesome because it includes too much, like semicolons. :(
hi! link zshOperator Operator
" Variation: This actually looks nicer as a Special.
hi! link zshOption   Normal
hi! link zshQuoted   Special
" Variation: I'd probably prefer this to be something else, actually.
" XXX: This doesn't work particularly well here...but most of the time, we're
"     in quotes, so let's go with that.
hi! link zshSubst    String
" Variation: I actually like keeping this as Type.
hi! link zshTypes    Keyword
" XXX: Other known deficiencies:
"
" * Semicolons in `if` blocks are `Keyword`ed in Kruez but not distinct in
"     Vim
" * Commands aren't distinct from builtins and keywords in Vim

