module OH
  def self.name(value)
    return value unless value.blank?
    return R.scope if R.scope?

    raise 'Name must be specified or scope should be active'
  end

  def self.extract_name(options)
    return options[:name] if options.key? :name
    return R.scope if R.scope?

    raise 'Name must be specified or scope should be active'
  end

  def self.mandatory(key, options)
    raise "Argument #{key} must be specified" unless options.key? key

    options[key]
  end

  def self.optional(key, options)
    options.fetch(key, nil)
  end
end
