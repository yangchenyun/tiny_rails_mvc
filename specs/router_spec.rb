require_relative 'spec_helper'
require 'router'

describe Router do
  describe '#router' do
    it 'returns an array of controller_name and action_name' do
      subject.router('/home/nice').should == ['home', 'nice']
    end

    it 'returns a default controller for home' do
      subject.router('/home').should == ['home', 'index']
    end

    it 'returns a default controller and default action' do
      subject.router('/').should == ['home', 'index']
    end
  end

  describe "#load_controller_class" do
    it 'loads the proper ControllerClass to the module namespace' do
      subject.load_controller_class('home')
      Object.const_defined?(:HomeController).should be_true
    end
  end
end
