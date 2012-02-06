require 'spec_helper'

describe Appointment do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @valid_attributes = {
      :start_date => Time.now,
      :end_date => Time.now,
      :note => "dagobert ist doof",
      :priority_number => 3,
      :group_id => 1,
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Appointment.create!(@valid_attributes)
  end
end
