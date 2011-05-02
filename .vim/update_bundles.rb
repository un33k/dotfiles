#!/usr/bin/env ruby

git_bundles = [ 
  "git://github.com/tsaleh/vim-supertab.git",            # supertab
  "git://github.com/rstacruz/sparkup.git",               # zen coding
  "git://github.com/tpope/vim-surround.git",             # surround operations
  "git://github.com/tpope/vim-repeat.git",               # improved repeat operations
  "git://github.com/tsaleh/vim-align.git",               # alignments helper
  "git://github.com/scrooloose/nerdtree.git",            # nerdtree
  "git://github.com/scrooloose/nerdcommenter.git",       # nerd commenter
  "git://github.com/tpope/vim-pathogen.git",             # pathogen
  "git://github.com/vim-scripts/pyflakes.vim.git",       # pyflakes support
  "git://github.com/omab/vim-pep8.git",                  # pep8 checking (my version)
  "git://github.com/omab/jslint.vim.git",                # jslint (my version)
  "git://github.com/vim-scripts/dbext.vim.git",          # dbext
  "git://github.com/vim-scripts/Command-T.git",          # command-t
  "git://github.com/kchmck/vim-coffee-script.git",       # coffee-script
  "git://github.com/vim-scripts/python_open_module.git", # open python module
  "git://github.com/sjl/gundo.vim.git",                  # gundo
  "git://github.com/tpope/vim-fugitive.git",             # fugitive
  "git://github.com/gregsexton/gitv.git",                # gitv
# "git://github.com/vim-scripts/pythoncomplete.git",     # updated python complete
# "git://github.com/msanders/snipmate.vim.git",          # snippets a la TextMate
# "git://github.com/tpope/vim-haml.git",                 # haml and sass syntax and indenting
# "git://github.com/tpope/vim-markdown.git",             # markdown syntax
]

vim_org_scripts = [
  ["jquery", "12107", "syntax"],
  ["django", "13026", "syntax"],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

#puts "Trashing everything (lookout!)"
#Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
    dir = url.split('/').last.sub(/\.git$/, '')
    if not File.directory? dir
        puts "  Unpacking #{url} into #{dir}"
        `git clone #{url} #{dir}`
        FileUtils.rm_rf(File.join(dir, ".git"))
    end
end

vim_org_scripts.each do |name, script_id, script_type|
    local_file = File.join(name, script_type, "#{name}.vim")
    dir = File.dirname(local_file)

    if not File.directory? dir
        puts "  Downloading #{name}"
        FileUtils.mkdir_p(dir)
        File.open(local_file, "w") do |file|
            file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
        end
    end
end
