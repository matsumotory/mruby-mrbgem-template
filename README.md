# mruby-mrbgem-template   [![Build Status](https://travis-ci.org/matsumoto-r/mruby-mrbgem-template.png?branch=master)](https://travis-ci.org/matsumoto-r/mruby-mrbgem-template)
MrbgemTemplate class
## install by mrbgems 
- add conf.gem line to `build_config.rb` 

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :git => 'https://github.com/matsumoto-r/mruby-mrbgem-template.git'
end
```
## example 

- input create.rb

```ruby
params = {
  :mrbgem_name    => 'mruby-sample',
  :license        => 'MIT',
  :github_user    => 'matsumoto-r',
  :mrbgem_prefix  => '..',
  :class_name     => 'Sample',
  :author         => 'MATSUMOTO Ryosuke',
}

c = MrbgemTemplate.new params
c.create
```

- output mrbgem template

```
$ ./bin/mruby create.rb
Generate all files of mruby-sample
create dir : ../mruby-sample
create dir : ../mruby-sample/src
create file: ../mruby-sample/src/mrb_sample.c
create file: ../mruby-sample/src/mrb_sample.h
create dir : ../mruby-sample/mrblib
create file: ../mruby-sample/mrblib/mrb_sample.rb
create dir : ../mruby-sample/test
create file: ../mruby-sample/test/mrb_sample.rb
create file: ../mruby-sample/mrbgem.rake
create file: ../mruby-sample/mruby-sample.gem
create file: ../mruby-sample/.travis.yml
create file: ../mruby-sample/.travis_build_config.rb
create file: ../mruby-sample/README.md
create file: ../mruby-sample/LICENSE

  > create matsumoto-r/mruby-sample repository on github.
  > turn on Travis CI https://travis-ci.org/profile of matsumoto-r/mruby-sample repository.
  > edit your mruby-sample code, then run the following command:

  cd ../mruby-sample
  git init
  git add .
  git commit -m "first commit"
  git remote add origin git@github.com:matsumoto-r/mruby-sample.git
  git push -u origin master
  
  > finally, pull-request mruby-sample.gem to mgem-list https://github.com/bovi/mgem-list

```

- all methods

```ruby
params = {
  :mrbgem_name    => 'mruby-sample',
  :license        => 'MIT',
  :github_user    => 'matsumoto-r',
  :mrbgem_prefix  => '.',
  :class_name     => 'Sample',
  :author         => 'MATSUMOTO Ryosuke',
}

c = MrbgemTemplate.new params

# Create all data
c.create

# Create root dir
#c.create_root

# Create src dir and .c .h
#c.create_src

# Create mrblib dir and .rb
#c.create_mrblib

# Create mrbgem.rake
#c.create_rake

# Create gem file
#c.create_mgem

# Create test dir and .rb
#c.create_test

# Create .travis.yaml and .travis config
#c.create_ci

# Create README.md
#c.create_readme

# Create LICENS
#c.create_license

# Output github infomation
#c.git_info

# Get data
#puts c.mrblib_data
#puts c.src_c_data
#puts c.src_h_data
#puts c.rake_data
#puts c.mgem_data
#puts c.test_data
#puts c.travis_ci_data
#puts c.travis_build_config_data
#puts c.readme_data
#puts c.license_data

# Set data
#c.mrblib_data = "hogehoge"
#.
#.
#.

# Get init data
#puts c.mrblib_data_init
#.
#.
#.

```


## License
under the MIT License:
- see LICENSE file
