# -*- encoding: utf-8 -*-

require 'spec_helper'

describe StubFactory do
  describe 'OpenStruct' do
    factory(String)

    it 'should define a String instance' do
      string('this is a string')[0..3].should == 'this'
    end
  end

  describe 'Array overriding method name' do
    factory(Array, :method_name => 'collection')

    it 'should define an Array instance' do
      collection([1, 2, 3]).length.should == 3
    end
  end
end
