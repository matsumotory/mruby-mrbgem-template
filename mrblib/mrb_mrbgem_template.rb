class MrbgemTemplate

  attr_accessor :src_c_data, :src_h_data, :mrblib_data
  attr_accessor :test_data, :rake_data, :readme_data, :license_data
  attr_accessor :travis_ci_data, :travis_build_config_data, :mgem_data

  def initialize(params = {})

    # Required params
    #  :mrbgem_name    => 'mruby-hogehoge',
    #  :license        => 'MIT',
    #  :github_user    => 'matsumoto-r',

    # Optional params (auto complete from Required data)
    #  :mrbgem_prefix  => '.',
    #  :mrbgem_type    => 'class',  # not yet
    #  :class_name     => 'Hogehoge',
    #  :author         => 'mruby-hogehoge developers',

    raise "mrbgem_name is nil" if params[:mrbgem_name].nil?
    raise "license is nil" if params[:license].nil?
    raise "github_user is nil" if params[:github_user].nil?

    @params = params
    @params[:mrbgem_prefix] = "." if @params[:mrbgem_prefix].nil?
    @params[:author] = "#{@params[:mrbgem_name]} developers" if @params[:author].nil?
    @params[:class_name] = @params[:mrbgem_name].split('-')[1].capitalize if @params[:class_name].nil?

    raise "not found prefix directory: #{@params[:mrbgem_prefix]}" if ! Dir.exist? @params[:mrbgem_prefix]
    @root_dir   = @params[:mrbgem_prefix] + "/" + @params[:mrbgem_name]
    @src_dir    = @root_dir + "/src"
    @mrblib_dir = @root_dir + "/mrblib"
    @test_dir   = @root_dir + "/test"
    
    @src_c_data = src_c_data_init
    @src_h_data = src_h_data_init
    @mrblib_data = mrblib_data_init
    @test_data = test_data_init
    @rake_data = rake_data_init
    @travis_ci_data = travis_ci_data_init
    @travis_build_config_data = travis_build_config_data_init
    @readme_data = readme_data_init
    @license_data = license_data_init
    @mgem_data = mgem_data_init
  end

  def create 
    puts "Generate all files of #{@params[:mrbgem_name]}"
    create_root
    create_src
    create_mrblib
    create_test
    create_rake
    create_mgem
    create_ci
    create_readme
    create_license
    git_info
  end

  def create_root
    if ! Dir.exist? @root_dir
      Dir.mkdir @root_dir, 0755
      puts "create dir : #{@root_dir}"
    end
  end

  def create_src
    create_root
    if Dir.exist? @src_dir
      puts "  skip dir : #{@src_dir}"
    else
      Dir.mkdir @src_dir, 0755
      puts "create dir : #{@src_dir}"
    end
    File.open("#{@src_dir}/mrb_#{@params[:class_name].downcase}.c", "w") do |file|
      file.puts @src_c_data
    end
    puts "create file: #{@src_dir}/mrb_#{@params[:class_name].downcase}.c"
    File.open("#{@src_dir}/mrb_#{@params[:class_name].downcase}.h", "w") do |file|
      file.puts @src_h_data
    end
    puts "create file: #{@src_dir}/mrb_#{@params[:class_name].downcase}.h"
  end

  def create_mrblib
    create_root
    if Dir.exist? @mrblib_dir
      puts "  skip dir : #{@mrblib_dir}"
    else
      Dir.mkdir @mrblib_dir, 0755
      puts "create dir : #{@mrblib_dir}"
    end
    File.open("#{@mrblib_dir}/mrb_#{@params[:class_name].downcase}.rb", "w") do |file|
      file.puts @mrblib_data
    end
    puts "create file: #{@mrblib_dir}/mrb_#{@params[:class_name].downcase}.rb"
  end

  def create_rake
    create_root
    File.open("#{@root_dir}/mrbgem.rake", "w") do |file|
      file.puts @rake_data
    end
    puts "create file: #{@root_dir}/mrbgem.rake"
  end

  def create_mgem
    create_root
    File.open("#{@root_dir}/#{@params[:mrbgem_name]}.gem", "w") do |file|
      file.puts @mgem_data
    end
    puts "create file: #{@root_dir}/#{@params[:mrbgem_name]}.gem"
  end

  def create_test
    create_root
    if Dir.exist? @test_dir
      puts "  skip dir : #{@test_dir}"
    else
      Dir.mkdir @test_dir, 0755
      puts "create dir : #{@test_dir}"
    end
    File.open("#{@test_dir}/mrb_#{@params[:class_name].downcase}.rb", "w") do |file|
      file.puts @test_data
    end
    puts "create file: #{@test_dir}/mrb_#{@params[:class_name].downcase}.rb"
  end

  def create_ci
    create_root
    File.open("#{@root_dir}/.travis.yml", "w") do |file|
      file.puts @travis_ci_data
    end
    puts "create file: #{@root_dir}/.travis.yml"
    File.open("#{@root_dir}/.travis_build_config.rb", "w") do |file|
      file.puts @travis_build_config_data
    end
    puts "create file: #{@root_dir}/.travis_build_config.rb"
  end

  def create_readme
    create_root
    File.open("#{@root_dir}/README.md", "w") do |file|
      file.puts @readme_data
    end
    puts "create file: #{@root_dir}/README.md"
  end
  def create_license
    create_root
    File.open("#{@root_dir}/LICENSE", "w") do |file|
      file.puts @license_data
    end
    puts "create file: #{@root_dir}/LICENSE"
  end

  def git_info
    puts <<DATA

  > create #{@params[:github_user]}/#{@params[:mrbgem_name]} repository on github.
  > turn on Travis CI https://travis-ci.org/profile of #{@params[:github_user]}/#{@params[:mrbgem_name]} repository.
  > edit your #{@params[:mrbgem_name]} code, then run the following command:
  
  cd #{@root_dir}
  git init
  git add .
  git commit -m "first commit"
  git remote add origin git@github.com:#{@params[:github_user]}/#{@params[:mrbgem_name]}.git
  git push -u origin master

DATA
  end

  def mrblib_data_init
    <<DATA
class #{@params[:class_name]}
  def bye
    self.hello + " bye"
  end
end
DATA
  end

  def rake_data_init
    <<DATA
MRuby::Gem::Specification.new('#{@params[:mrbgem_name]}') do |spec|
  spec.license = '#{@params[:license]}'
  spec.authors = '#{@params[:author]}'
end
DATA
  end

  def test_data_init
    <<DATA
##  
## #{@params[:class_name]} Test
##

assert("#{@params[:class_name]}#hello") do
  t = #{@params[:class_name]}.new "hello"
  assert_equal("hello", t.hello)
end

assert("#{@params[:class_name]}#bye") do
  t = #{@params[:class_name]}.new "hello"
  assert_equal("hello bye", t.bye)
end

assert("#{@params[:class_name]}.hi") do
  assert_equal("hi!!", #{@params[:class_name]}.hi)
end
DATA
  end

  def travis_ci_data_init
    <<DATA
language: c
compiler:
  - gcc
  - clang
before_install:
    - sudo apt-get -qq update
install:
    - sudo apt-get -qq install rake bison git gperf
before_script:
  - cd ../
  - git clone https://github.com/mruby/mruby.git
  - cd mruby
  - cp -fp ../#{@params[:mrbgem_name]}/.travis_build_config.rb build_config.rb
script: 
  - rake all test
DATA
  end

  def travis_build_config_data_init
    <<DATA
MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'
  conf.gem '../#{@params[:mrbgem_name]}'
end
DATA
  end

  def readme_data_init
    <<DATA
# #{@params[:mrbgem_name]}   [![Build Status](https://travis-ci.org/#{@params[:github_user]}/#{@params[:mrbgem_name]}.png?branch=master)](https://travis-ci.org/#{@params[:github_user]}/#{@params[:mrbgem_name]})
#{@params[:class_name]} class
## install by mrbgems 
- add conf.gem line to `build_config.rb` 

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :git => 'https://github.com/#{@params[:github_user]}/#{@params[:mrbgem_name]}.git'
end
```
## example 
```ruby
p #{@params[:class_name]}.hi
#=> "hi!!"
t = #{@params[:class_name]}.new "hello"
p t.hello
#=> "hello"
p t.bye
#=> "hello bye"
```

## License
under the #{@params[:license]} License:
- see LICENSE file
DATA
  end

  def license_data_init
    if @params[:license] == "MIT"

      <<DATA
#{@params[:mrbgem_name]}

Copyright (c) #{@params[:author]} #{Time.new.localtime.year}

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[ MIT license: http://www.opensource.org/licenses/mit-license.php ]

DATA
    else
      "write license information here." 
    end
  end

  def src_h_data_init
    <<DATA
/*
** mrb_#{@params[:class_name].downcase}.h - #{@params[:class_name]} class 
**
** See Copyright Notice in LICENSE
*/

#ifndef MRB_#{@params[:class_name].upcase}_H
#define MRB_#{@params[:class_name].upcase}_H

void mrb_mruby_#{@params[:class_name].downcase}_gem_init(mrb_state *mrb);

#endif
DATA
  end

  def src_c_data_init
    <<DATA
/*
** mrb_#{@params[:class_name].downcase}.c - #{@params[:class_name]} class
**
** Copyright (c) #{@params[:author]} #{Time.new.localtime.year}
**
** See Copyright Notice in LICENSE
*/

#include "mruby.h"
#include "mruby/data.h"
#include "mrb_#{@params[:class_name].downcase}.h"

#define DONE mrb_gc_arena_restore(mrb, 0);

typedef struct {
  char *str;
  int len;
} mrb_#{@params[:class_name].downcase}_data;

static const struct mrb_data_type mrb_#{@params[:class_name].downcase}_data_type = {
  "mrb_#{@params[:class_name].downcase}_data", mrb_free,
};

static mrb_value mrb_#{@params[:class_name].downcase}_init(mrb_state *mrb, mrb_value self)
{
  mrb_#{@params[:class_name].downcase}_data *data;
  char *str;
  int len;

  data = (mrb_#{@params[:class_name].downcase}_data *)DATA_PTR(self);
  if (data) {
    mrb_free(mrb, data);
  }
  DATA_TYPE(self) = &mrb_#{@params[:class_name].downcase}_data_type;
  DATA_PTR(self) = NULL;

  mrb_get_args(mrb, "s", &str, &len);
  data = (mrb_#{@params[:class_name].downcase}_data *)mrb_malloc(mrb, sizeof(mrb_#{@params[:class_name].downcase}_data));
  data->str = str;
  data->len = len;
  DATA_PTR(self) = data;

  return self;
}

static mrb_value mrb_#{@params[:class_name].downcase}_hello(mrb_state *mrb, mrb_value self)
{
  mrb_#{@params[:class_name].downcase}_data *data = DATA_PTR(self);

  return mrb_str_new(mrb, data->str, data->len);
}

static mrb_value mrb_#{@params[:class_name].downcase}_hi(mrb_state *mrb, mrb_value self)
{
  return mrb_str_new_cstr(mrb, "hi!!");
}

void mrb_mruby_#{@params[:class_name].downcase}_gem_init(mrb_state *mrb)
{
    struct RClass *#{@params[:class_name].downcase};
    #{@params[:class_name].downcase} = mrb_define_class(mrb, "#{@params[:class_name]}", mrb->object_class);
    mrb_define_method(mrb, #{@params[:class_name].downcase}, "initialize", mrb_#{@params[:class_name].downcase}_init, MRB_ARGS_REQ(1));
    mrb_define_method(mrb, #{@params[:class_name].downcase}, "hello", mrb_#{@params[:class_name].downcase}_hello, MRB_ARGS_NONE());
    mrb_define_class_method(mrb, #{@params[:class_name].downcase}, "hi", mrb_#{@params[:class_name].downcase}_hi, MRB_ARGS_NONE());
    DONE;
}

void mrb_mruby_#{@params[:class_name].downcase}_gem_final(mrb_state *mrb)
{
}

DATA
  end

  def mgem_data_init
    <<DATA
name: #{@params[:mrbgem_name]}
description: #{@params[:class_name]} class
author: #{@params[:author]}
website: https://github.com/#{@params[:github_user]}/#{@params[:mrbgem_name]}
protocol: git
repository: https://github.com/#{@params[:github_user]}/#{@params[:mrbgem_name]}.git
DATA
  end
end
