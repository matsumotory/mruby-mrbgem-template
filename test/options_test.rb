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
