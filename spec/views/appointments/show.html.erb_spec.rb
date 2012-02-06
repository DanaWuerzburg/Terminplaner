require 'spec_helper'

describe "appointments/show" do
  before(:each) do
    @appointment = assign(:appointment, stub_model(Appointment,
      :note => "Note",
      :priority_number => 1,
      :group => "Group",
      :user_id => 1,
      :group_id => 1,
      :color => "Color",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Note".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain("Group".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain("Color".to_s)
    rendered.should contain("Name".to_s)
  end
end
