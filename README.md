# vnotes

## Introduction

This is a vim plugin to write books and to take notes. Although currently it is not as 
flexible as the plugins for the sum of its parts offer it works in vanilla vim editions
with no additional functionalities required.

## Installations

Add this to your .vimrc:
	filetype on
	autocmd BufNewFile,BufRead *.rit set filetype=rit

Thie plugin manager you are using must be able to dynamically load plugins for filetypes
for which you would like this plugin to be loaded
For vim-plug:
	- Plug 'Leonkoithara/vwrite', { 'for': 'rit'}

## Usage

To load this plugin open a new file with file extension rit or ask your plugin manager to 
load this plugin for other filetype(eg: 'txt').
Read the documentation for more details.

## Contribution

A Contributors.txt exists to which people who extensively contributed to this project are 
added.

## License

Copyright (c) Leon Joe Koithara. Distributed under the same terms as Vim itself.
See ':help license'.
