assert("MrbgemTemplate.parse_options!") do
  argv = [
    "-l", "Apache 2.0",
    "-u", "matsumoto-r",
    "-p", "/path/to/root",
    "-c", "FooClass",
    "-a", "Ryosuke Matsumoto",
    "--no-local-builder",
    "--no-ci",
    "mruby-buz"
  ]
  params = MrbgemTemplate.parse_options!(argv)

  assert_equal(params[:license], "Apache 2.0")
  assert_equal(params[:github_user], "matsumoto-r")
  assert_equal(params[:mrbgem_prefix], "/path/to/root")
  assert_equal(params[:class_name], "FooClass")
  assert_equal(params[:author], "Ryosuke Matsumoto")
  assert_equal(params[:local_builder], false)
  assert_equal(params[:ci], false)
  assert_equal(params[:mrbgem_name], "mruby-buz")
end

assert("MrbgemTemplate.parse_options! default values") do
  argv = [
    "-u", "dummy-user",
    "-a", "Dummy authors", # todo: mock git command response?
    "mruby-qaaz_qez"
  ]
  params = MrbgemTemplate.parse_options!(argv)

  assert_equal(params[:license], "MIT")
  assert_equal(params[:github_user], "dummy-user")
  assert_equal(params[:mrbgem_prefix], ".")
  assert_equal(params[:class_name], "QaazQez")
  assert_equal(params[:author], "Dummy authors")
  assert_equal(params[:local_builder], true)
  assert_equal(params[:ci], true)
  assert_equal(params[:mrbgem_name], "mruby-qaaz_qez")
end
