require 'spec_helper'

describe "appointments/new" do
  before(:each) do
    assign(:appointment, stub_model(Appointment,
      :note => "MyString",
      :priority_number => 1,
      :group => "MyString",
      :user_id => 1,
      :group_id => 1,
      :color => "MyString",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new appointment form" do
    render

    rendered.should have_selector("form", :action => appointments_path, :method => "post") do |form|
      form.should have_selector("input#appointment_note", :name => "appointment[note]")
      form.should have_selector("input#appointment_priority_number", :name => "appointment[priority_number]")
      form.should have_selector("input#appointment_group", :name => "appointment[group]")
      form.should have_selector("input#appointment_user_id", :name => "appointment[user_id]")
      form.should have_selector("input#appointment_group_id", :name => "appointment[group_id]")
      form.should have_selector("input#appointment_color", :name => "appointment[color]")
      form.should have_selector("input#appointment_name", :name => "appointment[name]")
    end
  end
end
