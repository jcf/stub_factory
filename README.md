# stub_factory

In your spec_helper

    require 'stub_factory'
    # Optionally include StubFactory

In your specs

    factory(NextBigThing::Ninja::Foo)

    describe "awesomeness" do
      it "should be easy" do
        foo(:stub => 'this).should be_a?(NextBigThing::Ninja::Foo)
      end
    end

You can also specify the method name you want to use to access your instance

    factory(NextBigThing::Ninja::Foo, :method_name => :ninja_foo)

    describe "awesomeness" do
      it "should be easy" do
        # Then you can access your instance using your preferred method name
        ninja_foo(:stub => 'this).should be_a?(NextBigThing::Ninja::Foo)
      end
    end

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 James Conroy-Finn. See LICENSE for details.