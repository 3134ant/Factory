class Factory
  def self.new(*args, &block)
    Class.new do
      args.each { |arg| self.send(:attr_accessor, arg) }

      define_method :initialize do |*params|
        raise ArgumentError if params.size > args.size
        params.each_with_index { |param, index| instance_variable_set("@#{args[index]}", param) }
      end

      define_method :[] do |option|
        class_name = option.class.name.to_s

        case class_name
        when 'Fixnum', 'Bignum'
          instance_variable_get("@#{args[option]}") if option < args.size
        when 'String'
          instance_variable_get("@#{args[args.index(option.to_sym)]}") if args.include?(option.to_sym)
        when 'Symbol'
          instance_variable_get("@#{args[args.index(option)]}") if args.include?(option)
        else
          raise ArgumentError
        end
      end

      self.class_eval(&block) if block_given?
    end
  end
end