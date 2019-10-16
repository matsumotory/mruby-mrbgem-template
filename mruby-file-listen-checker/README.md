# mruby-file-listen-checker   [![Build Status](https://travis-ci.org/pyama86/mruby-file-listen-checker.svg?branch=master)](https://travis-ci.org/pyama86/mruby-file-listen-checker)
FileListenCheck class
## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'pyama86/mruby-file-listen-checker'
end
```
## example
```ruby
FileListenCheck.new("0.0.0.0", 11111).listen?
```

## License
under the MIT License:
- see LICENSE file
