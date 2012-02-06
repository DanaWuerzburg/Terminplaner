require 'spec_helper'

describe Group do
  before(:each) do
    @valid_attributes = {
      :name => "Arbeit",
      :description => "Arbeits angelegenheiten",
      :colour => "#33ff33",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Group.create!(@valid_attributes)
  end
end
