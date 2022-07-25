def __main__(argv)
  params = MrbgemTemplate.parse_options!(argv)
  c = MrbgemTemplate.new params

  c.create
rescue MrbgemTemplate::IllegalParameterError => e
  puts e.message
  exit 1
end
