require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
 #   pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @valid_attributes = {
      :login => "Dagobert",
      :email => "dagobert@mail.com",
      :password => "dagobert",
      :password_confirmation => "dagobert"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
