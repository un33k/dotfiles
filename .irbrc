require 'rubygems'              # rubygems
#require 'ap'                    # awesome print
require 'bond'                  # improved completion
#require 'looksee'               # intropection
#require 'interactive_editor'    # popup an editor
require 'ripl'                  # ripl
require 'ripl/multi_line'       # ripl: multiline support
require 'ripl/color_error'      # ripl: colored errors
require 'ripl/color_streams'    # ripl: in/out colors
require 'ripl/color_result'     # ripl: colored results
require 'ripl/commands'         # ripl: extra commands
require 'ripl/auto_indent'      # ripl: multiline auto indent

# Ripl.config[:prompt] = ">> ".green

# better completion
Bond.start
