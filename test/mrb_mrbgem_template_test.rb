##
## MrbgemTemplate Test
##

assert("MrbgemTemplate#*_data") do
  params = {
    :mrbgem_name    => 'mruby-sample',
    :license        => 'MIT',
    :github_user    => 'matsumoto-r',
    :mrbgem_prefix  => '..',
    :class_name     => 'Sample',
    :author         => 'MATSUMOTO Ryosuke',
  }

  c = MrbgemTemplate.new params
  assert_equal(c.src_c_data, c.src_c_data_init)
  assert_equal(c.src_h_data, c.src_h_data_init)
  assert_equal(c.mrblib_data, c.mrblib_data_init)
  assert_equal(c.rake_data, c.rake_data_init)
  assert_equal(c.mgem_data, c.mgem_data_init)
  assert_equal(c.test_data, c.test_data_init)
  assert_equal(c.license_data, c.license_data_init)
  assert_equal(c.readme_data, c.readme_data_init)
  assert_equal(c.github_actions_data, c.github_actions_data_init)
  assert_equal(c.github_actions_build_config_data, c.github_actions_build_config_data_init)
end

assert("MrbgemTemplate#*_data=") do
  params = {
    :mrbgem_name    => 'mruby-sample',
    :license        => 'MIT',
    :github_user    => 'matsumoto-r',
    :mrbgem_prefix  => '..',
    :class_name     => 'Sample',
    :author         => 'MATSUMOTO Ryosuke',
  }

  c = MrbgemTemplate.new params
  c.src_c_data = "aaa"
  assert_equal("aaa", c.src_c_data)
  c.src_h_data = "bbb"
  assert_equal("bbb", c.src_h_data)
  c.mrblib_data = "ccc"
  assert_equal("ccc", c.mrblib_data)
  c.rake_data = "rake"
  assert_equal("rake", c.rake_data)
  c.mgem_data = "mgem"
  assert_equal("mgem", c.mgem_data)
  c.test_data = "test"
  assert_equal("test", c.test_data)
  c.license_data = "license"
  assert_equal("license", c.license_data)
  c.readme_data = "readme"
  assert_equal("readme", c.readme_data)
  c.github_actions_data = "ci"
  assert_equal("ci", c.github_actions_data)
  c.github_actions_build_config_data = "build"
  assert_equal("build", c.github_actions_build_config_data)
end

assert("MrbgemTemplate#gemname_to_funcname") do
  params = {
    :mrbgem_name    => 'mruby-sample',
    :license        => 'MIT',
    :github_user    => 'matsumoto-r',
    :mrbgem_prefix  => '..',
    :class_name     => 'Sample',
    :author         => 'MATSUMOTO Ryosuke',
  }

  c = MrbgemTemplate.new params
  assert_equal("mrb_mruby_sample_gem_init", c.gemname_to_funcname('init'))
  assert_equal("mrb_mruby_sample_gem_final", c.gemname_to_funcname('final'))

  params = {
    :mrbgem_name    => 'mruby-complex-sample',
    :license        => 'MIT',
    :github_user    => 'matsumoto-r',
    :mrbgem_prefix  => '..',
    :class_name     => 'Sample',
    :author         => 'MATSUMOTO Ryosuke',
  }

  c = MrbgemTemplate.new params
  assert_equal("mrb_mruby_complex_sample_gem_init", c.gemname_to_funcname('init'))
  assert_equal("mrb_mruby_complex_sample_gem_final", c.gemname_to_funcname('final'))
end
