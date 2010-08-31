# -*- encoding: utf-8 -*-

module StubFactory
  module StringExtensions
    def underscore
      gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr('-', '_').
        downcase
    end
  end

  module ArrayExtensions
    def extract_options!
      last.is_a?(Hash) ? pop : {}
    end
  end

  # InstanceFactory does all the work. You can access it directly but you
  # should probably just include StubFactory and use the factory helper method.
  #
  # BTW, It's called InstanceFactory and not just Factory so it can be included
  # when you're using FactoryGirl
  class InstanceFactory
    # We don't want to extend all strings in case you've got your own
    # underscore method.
    def initialize(receiver, klass, options = {})
      @receiver    = receiver
      @klass       = klass
      @method_name = options[:method_name]
    end

    def with(args)
      @args = args
      self
    end

    def stub!(stubs = {})
      @stubs = stubs
      self
    end

    def result
      retrieve_instance || publish_instance
    end

    def method_name
      @method_name || klass_name
    end

    private

    def klass_name
      @klass.to_s.extend(StringExtensions).underscore.split('/').last
    end

    def instance
      @klass.new(*@args).tap { |_instance| _instance.stub!(@stubs) }
    end

    def instance_name
      "@__stub_factory_#{method_name}"
    end

    def retrieve_instance
      @receiver.instance_variable_get(instance_name)
    end

    def publish_instance
      @receiver.instance_variable_set(instance_name, instance)
    end
  end

  def factory(klass, options = {})
    _factory = InstanceFactory.new(self, klass, options)
    define_method(_factory.method_name) do |*args|
      stubs = args.extend(ArrayExtensions).extract_options!
      _factory.with(args).stub!(stubs).result
    end
  end
end
