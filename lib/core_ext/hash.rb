class Hash
  def rubyize_keys
    convert_hash_keys(self)
  end

private
  def convert_hash_keys(value)
    case value
    when Hash
      Hash[value.map { |k, v| [rubyize_key(k), convert_hash_keys(v)] }]
    when Array
      value.map { |v| convert_hash_keys(v) }
    else
      value
    end
  end

  def rubyize_key(key)
    key.to_s.underscore.sub(/class/, 'klass').to_sym
  end
end