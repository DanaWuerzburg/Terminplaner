require 'spec_helper'

describe UserSession do
  before(:each) do
    @valid_attributes = {
      :login => "Dagobert",
      :password => "dagobert"
    }
  end

  it "should create a new instance given valid attributes" do
    UserSession.create!(@valid_attributes)
  end
end
