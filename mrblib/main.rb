def __main__
  params = {
    :mrbgem_name    => 'mruby-probe',
    :license        => 'MIT',
    :github_user    => 'udzura',
    :mrbgem_prefix  => '.',
    :class_name     => 'Probe',
    :author         => 'Uchio Kondo',
    :local_builder  => true,
    :ci             => true,
  }

  c = MrbgemTemplate.new params

  c.create
end
