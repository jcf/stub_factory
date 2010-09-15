# stub_factory

This is just something I was working on for fun a while back and decided I'd
push it to Github.

Rspec provides `subject` which will do most of what this code does. You
probably want to use that instead.

## Installation

    gem install stub_factory

Or you can \[fork and\] clone the repo and install it using Jeweler's `rake
install` task.

## Usage

In your spec_helper

    require 'stub_factory'
    # Optionally include StubFactory

In your specs

    factory(NextBigThing::Ninja::Foo)

    describe 'awesomeness' do
      it 'should be easy' do
        foo(:stub => 'this').should be_a?(NextBigThing::Ninja::Foo)
      end
    end

You can also specify the method name you want to use to access your instance

    factory(NextBigThing::Ninja::Foo, :method_name => :ninja_foo)

    describe 'awesomeness' do
      it 'should be easy' do
        # Then you can access your instance using your preferred method name
        ninja_foo(:stub => 'this').should be_a?(NextBigThing::Ninja::Foo)
      end
    end

Check out
[stub_factory_spec.rb](http://github.com/jcf/stub_factory/blob/master/spec/stub_factory_spec.rb)
to see `StubFactory` in use.

## Alternative Usage

If you already use FactoryGirl, as I do on a lot of my projects you may find the
following method useful as it allows you to setup similar persistent instances
of your Factories. Simple paste it in to your `spec_helper.rb`

    def factory(factory_name, options = {})
      method_name = (options[:method_name] || factory_name).to_s.to_sym

      define_method(method_name) do |*args|
        var_name = "@#{method_name}"
        value    = instance_variable_get(var_name)
        return value if value

        attributes = args.shift || {}
        stubs      = args.shift || {}

        super_mock = Proc.new { |factory_name, attributes, stubs|
          Factory(factory_name, attributes).tap do |super_mock|
            super_mock.stub!(stubs)
          end
        }

        instance_variable_set(var_name, super_mock.call(factory_name, attributes, stubs))
      end
    end

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a
  commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 James Conroy-Finn. See LICENSE for details.
