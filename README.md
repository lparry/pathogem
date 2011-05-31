# Pathogem

Pathogem will be a tool for managing your vim plugins in combination with [Tim Pope](https://github.com/tpope)'s wonderful [Pathogen](https://github.com/tpope/vim-pathogen). It aims to be like Rubygems for managing vim plugins.

## Usage

pathogem install surround

pathogem uninstall surround
pathogem update surround
pathogem update --all

option parsing libraries
 - https://github.com/injekt/slop
 - https://github.com/mdub/clamp
 - https://github.com/wycats/thor
guide to CLI tools in ruby: http://rubylearning.com/blog/2011/01/03/how-do-i-make-a-command-line-tool-in-ruby/

sources
github repos in the standard format
github repos in non-standard formats
vim.org scripts section (yuck)

1. lookup source
2. fetch source into tmp
3. install source to vim/bundle/source
3a. check if directory exists already, if so check if we installed it (manifest)
4. add bundle to manifest
