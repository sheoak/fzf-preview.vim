scriptencoding utf-8

if exists('s:loaded')
  finish
endif
let s:loaded = 1

if !exists('g:fzf_preview_use_floating_window')
  let g:fzf_preview_use_floating_window = has('nvim') ? 1 : 0
endif

if !exists('g:fzf_preview_floating_window_rate')
  let g:fzf_preview_floating_window_rate = 0.9
endif

if !exists('g:fzf_preview_floating_window_winblend')
  if &termguicolors
    let g:fzf_preview_floating_window_winblend = 15
  else
    let g:fzf_preview_floating_window_winblend = 0
  endif
endif

if !exists('g:fzf_preview_quit_map')
  let g:fzf_preview_quit_map = 1
endif

if !exists('g:fzf_preview_command')
  if executable('bat')
    let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
  else
    let g:fzf_preview_command = 'head -100 {-1}'
  endif
endif

if !exists('g:fzf_preview_if_binary_command')
  let g:fzf_preview_if_binary_command = '[[ "$(file --mime {})" =~ binary ]]'
endif

if !exists('g:fzf_binary_preview_command')
  let g:fzf_binary_preview_command = 'echo "{} is a binary file"'
endif

if !exists('g:fzf_preview_filelist_command')
  if executable('rg')
    let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages --glob "!.git/*" --glob \!"* *"'
  else
    let g:fzf_preview_filelist_command = 'git ls-files --exclude-standard'
  endif
endif

if !exists('g:fzf_preview_git_files_command')
  let g:fzf_preview_git_files_command = 'git ls-files --exclude-standard'
endif

if !exists('g:fzf_preview_directory_files_command')
  let g:fzf_preview_directory_files_command = 'rg --files --hidden --follow --no-messages -g \!"* *"'
endif

if !exists('g:fzf_preview_git_status_command')
  let g:fzf_preview_git_status_command = 'git -c color.status=always status --short --untracked-files=all'
endif

if !exists('g:fzf_preview_git_status_preview_command')
  let g:fzf_preview_git_status_preview_command =  "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} || " .
  \ "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} || " .
  \ g:fzf_preview_command
endif

if !exists('g:fzf_preview_grep_cmd')
  let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=always'
endif

if !exists('g:fzf_preview_lines_command')
  if executable('bat')
    let g:fzf_preview_lines_command = 'bat --color=always --plain --number --theme=ansi-dark'
  else
    let g:fzf_preview_lines_command = 'cat'
  endif
endif

if !exists('g:fzf_preview_grep_preview_cmd')
  let g:fzf_preview_grep_preview_cmd = expand('<sfile>:h:h') . '/bin/preview_fzf_grep'
endif

if !exists('g:fzf_preview_open_pr_command')
  let g:fzf_preview_open_pr_command = expand('<sfile>:h:h') . '/bin/git_blame_pr'
endif

if !exists('g:fzf_preview_cache_directory')
  let g:fzf_preview_cache_directory = expand('~/.cache/vim/fzf_preview')
endif

if !exists('g:fzf_preview_preview_key_bindings')
  let g:fzf_preview_preview_key_bindings =
        \ 'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'
endif

if !exists('g:fzf_preview_fzf_color_option')
  let g:fzf_preview_fzf_color_option = ''
endif

if !exists('g:fzf_preview_split_key_map')
  let g:fzf_preview_split_key_map = 'ctrl-x'
endif

if !exists('g:fzf_preview_vsplit_key_map')
  let g:fzf_preview_vsplit_key_map = 'ctrl-v'
endif

if !exists('g:fzf_preview_tabedit_key_map')
  let g:fzf_preview_tabedit_key_map = 'ctrl-t'
endif

if !exists('g:fzf_preview_drop_key_map')
  let g:fzf_preview_drop_key_map = 'ctrl-o'
endif

if !exists('g:fzf_preview_bdelete_key_map')
  let g:fzf_preview_bdelete_key_map = 'ctrl-x'
endif

if !exists('g:fzf_preview_build_quickfix_key_map')
  let g:fzf_preview_build_quickfix_key_map = 'ctrl-q'
endif

if !exists('g:fzf_preview_custom_default_processors')
  let g:fzf_preview_custom_default_processors = {}
endif

if !exists('g:fzf_preview_fzf_preview_window_option')
  let g:fzf_preview_fzf_preview_window_option = ''
endif

if !exists('g:fzf_preview_filelist_postprocess_command')
  let g:fzf_preview_filelist_postprocess_command = ''
endif

if !exists('g:fzf_preview_use_dev_icons')
  let g:fzf_preview_use_dev_icons = 0
endif

if !exists('g:fzf_preview_dev_icon_prefix_length')
  let g:fzf_preview_dev_icon_prefix_length = 5
endif

if !exists('g:fzf_preview_layout')
  let g:fzf_preview_layout = 'top split new'
endif

if !exists('g:fzf_preview_rate')
  let g:fzf_preview_rate = 0.3
endif

if !exists('g:fzf_full_preview_toggle_key')
  let g:fzf_full_preview_toggle_key = '<C-s>'
endif

let s:save_cpo = &cpoptions
set cpoptions&vim

command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewProjectFiles       :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:project_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewGitFiles           :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:git_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewDirectoryFiles     :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:directory_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewGitStatus          :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:git_status', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewBuffers            :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:buffers', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewAllBuffers         :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:all_buffers', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewProjectOldFiles    :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:project_oldfiles', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewProjectMruFiles    :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:project_mru_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewProjectMrwFiles    :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:project_mrw_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewLines              :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:lines', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewBufferLines        :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:buffer_lines', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewCtags              :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:ctags', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewBufferTags         :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:buffer_tags', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewOldFiles           :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:oldfiles', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewMruFiles           :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:mru_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewMrwFiles           :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:mrw_files', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewQuickFix           :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:locationlist', {'type': 'quickfix'}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewLocationList       :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:locationlist', {'type': 'loclist'}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewJumps              :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:jumps', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewChanges            :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:changes', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewMarks              :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:marks', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewConflict           :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:conflict', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewBlamePR            :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:blame_pr', {}, <f-args>))
command! -nargs=+ -complete=customlist,fzf_preview#args#complete_options         FzfPreviewProjectGrep        :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:project_grep', {}, <f-args>))
command! -nargs=* -complete=customlist,fzf_preview#args#complete_options         FzfPreviewProjectCommandGrep :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:project_command_grep', {}, <f-args>))
command! -nargs=+ -complete=customlist,fzf_preview#args#complete_files_resources FzfPreviewFromResources      :call fzf_preview#runner#fzf_run(fzf_preview#initializer#initialize('s:files_from_resources', {}, <f-args>))

augroup fzf_preview_buffers
  autocmd!
  if g:fzf_preview_quit_map
    autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-g>
    autocmd FileType fzf nnoremap <silent> <buffer> <C-g> i<C-g>
    autocmd FileType fzf vnoremap <silent> <buffer> <C-g> <Esc>i<C-g>
  endif
augroup END

augroup fzf_preview_mru
  autocmd!
  autocmd BufEnter,VimEnter,BufWinEnter,BufWritePost * call s:mru_append(expand('<amatch>'))
  autocmd BufWritePost * call s:mrw_append(expand('<amatch>'))
augroup END

function! s:mru_append(path) abort
  if s:enable_file(a:path)
    call fzf_preview#mr#append(a:path, fzf_preview#mr#mru_file_path())
  endif
endfunction

function! s:mrw_append(path) abort
  if s:enable_file(a:path)
    call fzf_preview#mr#append(a:path, fzf_preview#mr#mrw_file_path())
  endif
endfunction

function! s:enable_file(path) abort
  if bufnr('%') != expand('<abuf>') || a:path == ''
    return v:false
  else
    return v:true
  endif
endfunction

silent doautocmd User fzf_preview#initialized

let &cpoptions = s:save_cpo
unlet s:save_cpo

" vim:set expandtab shiftwidth=2 softtabstop=2 tabstop=2 foldenable foldmethod=marker:
