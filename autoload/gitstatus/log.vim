if exists('g:loaded_nerdtree_git_status_log')
    finish
endif
let g:loaded_nerdtree_git_status_log = 1

let s:debug   = 0 | :lockvar s:debug
let s:info    = 1 | :lockvar s:info
let s:warning = 2 | :lockvar s:warning
let s:error   = 3 | :lockvar s:error

let s:Logger = {}

function! s:Logger.output(level, msg) abort
    if a:level < self.level
        return
    endif
    echomsg '[nerdtree-git-status] ' . a:msg
endfunction

function! s:Logger.debug(msg) abort
    echohl LineNr |
                \ call self.output(s:debug, a:msg) |
                \ echohl None
endfunction

function! s:Logger.info(msg) abort
    call self.output(s:info, a:msg)
endfunction

function! s:Logger.warning(msg) abort
    echohl WarningMsg |
                \ call self.output(s:warning, a:msg) |
                \ echohl None
endfunction

function! s:Logger.error(msg) abort
    echohl ErrorMsg |
                \ call self.output(s:error, a:msg) |
                \ echohl None
endfunction

function! gitstatus#log#NewLogger(level) abort
    let obj = extend(copy(s:Logger), {'level': a:level})
    return obj
endfunction