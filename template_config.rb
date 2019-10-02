params = {
  :mrbgem_name    => 'mruby-example',
  :license        => 'MIT',
  :github_user    => 'your-github-username',
  :mrbgem_prefix  => File.expand_path('.'),
  :class_name     => 'Example',
  :author         => 'your-name',
  :bin_name       => 'foobar'
}

c = MrbgemTemplate.new params
c.create
