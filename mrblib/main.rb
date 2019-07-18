def __main__(argv)
  params = MrbgemTemplate.parse_options!(argv)
  c = MrbgemTemplate.new params

  c.create
end
