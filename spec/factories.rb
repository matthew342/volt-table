require 'faker'

module Factories

  def self.user(options = {})
    buffer = Volt.current_app.store.users.buffer
    timestamp = Time.now.to_i.to_s
    first_name = Faker::Name.first_name
    fields = {
        first_name: first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.safe_email("#{first_name}-#{timestamp}"),
        password: 'testing1234',
    }
    build_model(buffer, fields, options)
  end

  def self.custom_user(options = {}, first, last)
    buffer = Volt.current_app.store.users.buffer
    first_name = first
    last_name = last
    fields = {
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@sample.com",
        password: 'testing1234',
    }
    build_model(buffer, fields, options)
  end

  def self.build_model(buffer, fields, options)
    field_keys = fields.keys.push(*options.keys)
    field_keys.delete(:method)
    field_keys.each do |field|
      if options.keys.include?(field)
        buffer.send("#{field}=", options[field])
      else
        buffer.send("#{field}=", fields[field])
      end
    end
    buffer.save! if options[:method] == :save
    buffer
  end
end
