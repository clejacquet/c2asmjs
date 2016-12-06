class TypeVerification
  class << self
    @types = {
        integer: lambda { |value| value.respond_to? :to_i },
        float:   lambda { |value| value.respond_to? :to_f },
        string:  lambda { |value| value.respond_to? :to_s }
    }

    def is_value_of_type?(value, type)
      @types[type].call value
    end
  end
end