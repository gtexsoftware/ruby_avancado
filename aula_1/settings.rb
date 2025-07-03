class Settings
  def initialize
    @config = {}
  end

  def add(key, value)
    @config[key.to_sym] = value
    define_singleton_method(key) { @config[key.to_sym] }
    define_singleton_method("#{key}=") { |v| @config[key.to_sym] = v }
  end

  def method_missing(method, *args, &block)
    method_name = method.to_s
    if method_name.end_with?("=")
      key = method_name.chomp("=")
      add(key, args.first)
    elsif @config.key?(method)
      @config[method]
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    method_name = method.to_s
    @config.key?(method) || method_name.end_with?("=") || super
  end

  def get(key)
    send(key)
  end

  def set(key, value)
    send("#{key}=", value)
  end
end


settings = Settings.new
settings.add(:timeout, 30)
puts settings.timeout


settings.add(:mode, "production")
puts settings.mode


puts settings.respond_to?(:timeout)
puts settings.respond_to?(:retry)

puts settings.retry
