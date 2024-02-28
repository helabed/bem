# -*- encoding: utf-8 -*-
# stub: rubyzip 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rubyzip".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexander Simonov".freeze]
  s.date = "2024-02-28"
  s.email = ["alex@simonov.me".freeze]
  s.files = ["NEWS".freeze, "README.md".freeze, "Rakefile".freeze, "TODO".freeze, "lib/zip.rb".freeze, "lib/zip/central_directory.rb".freeze, "lib/zip/compressor.rb".freeze, "lib/zip/constants.rb".freeze, "lib/zip/decompressor.rb".freeze, "lib/zip/deflater.rb".freeze, "lib/zip/dos_time.rb".freeze, "lib/zip/entry.rb".freeze, "lib/zip/entry_set.rb".freeze, "lib/zip/errors.rb".freeze, "lib/zip/extra_field.rb".freeze, "lib/zip/extra_field/generic.rb".freeze, "lib/zip/extra_field/universal_time.rb".freeze, "lib/zip/extra_field/unix.rb".freeze, "lib/zip/extra_field/zip64.rb".freeze, "lib/zip/file.rb".freeze, "lib/zip/filesystem.rb".freeze, "lib/zip/inflater.rb".freeze, "lib/zip/input_stream.rb".freeze, "lib/zip/ioextras.rb".freeze, "lib/zip/ioextras/abstract_input_stream.rb".freeze, "lib/zip/ioextras/abstract_output_stream.rb".freeze, "lib/zip/null_compressor.rb".freeze, "lib/zip/null_decompressor.rb".freeze, "lib/zip/null_input_stream.rb".freeze, "lib/zip/output_stream.rb".freeze, "lib/zip/pass_thru_compressor.rb".freeze, "lib/zip/pass_thru_decompressor.rb".freeze, "lib/zip/streamable_directory.rb".freeze, "lib/zip/streamable_stream.rb".freeze, "lib/zip/version.rb".freeze, "samples/example.rb".freeze, "samples/example_filesystem.rb".freeze, "samples/example_recursive.rb".freeze, "samples/gtkRubyzip.rb".freeze, "samples/qtzip.rb".freeze, "samples/write_simple.rb".freeze, "samples/zipfind.rb".freeze]
  s.homepage = "http://github.com/rubyzip/rubyzip".freeze
  s.rubygems_version = "3.3.26".freeze
  s.summary = "rubyzip is a ruby module for reading and writing zip files".freeze

  s.installed_by_version = "3.3.26" if s.respond_to? :installed_by_version
end
