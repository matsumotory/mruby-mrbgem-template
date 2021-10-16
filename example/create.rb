params = {
  :mrbgem_name    => 'mruby-sample',
  :license        => 'MIT',
  :github_user    => 'matsumoto-r',
  :mrbgem_prefix  => '..',
  :class_name     => 'Sample',
  :author         => 'MATSUMOTO Ryosuke',
}

c = MrbgemTemplate.new params

# Create all data
c.create

#
# Other methods
#

# Create root dir
#c.create_root

# Create src dir and .c .h
#c.create_src

# Create mrblib dir and .rb
#c.create_mrblib

# Create mrbgem.rake
#c.create_rake

# Create .gem
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
#puts c.github_actions_data
#puts c.github_actions_build_config_data
#puts c.readme_data
#puts c.license_data

# Set data
#c.mrblib_data = "hogehoge"
#.
#.
#.

# Get init data
#c.mrblib_data = c.mrblib_data_init
#.
#.
#.
