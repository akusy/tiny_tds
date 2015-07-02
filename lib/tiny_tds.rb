# encoding: UTF-8
require 'date'
require 'bigdecimal'
require 'rational' unless RUBY_VERSION >= '1.9.2'

require 'tiny_tds/version'
require 'tiny_tds/error'
require 'tiny_tds/client'
require 'tiny_tds/result'

# Support multiple ruby versions, fat binaries under Windows.
if RUBY_PLATFORM =~ /mingw|mswin/ && RUBY_VERSION =~ /(\d+.\d+)/
  ver = $1
  # Set the PATH environment variable, so that the DLLs can be found.
  old_path = ENV['PATH']
  begin
    # Do the same host consolidation as in extconf.rb
    ports_dir = RbConfig::CONFIG["host"].gsub('i586-mingw32msvc', 'i686-w64-mingw32').
                                         gsub('i686-pc-mingw32', 'i686-w64-mingw32')
    ENV['PATH'] = "#{File.expand_path("../../ports/#{ports_dir}/bin", __FILE__)};#{old_path}"
    require "tiny_tds/#{ver}/tiny_tds"
  rescue LoadError
    require 'tiny_tds/tiny_tds'
  ensure
    ENV['PATH'] = old_path
  end
else
  require 'tiny_tds/tiny_tds'
end
