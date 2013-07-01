if File.exists?("#{Rails.root}/config/mail.yml") && !Rails.env.test?
  file = YAML.load_file("#{Rails.root}/config/mail.yml")
  config = file[Rails.env] if file

  # TODO
end