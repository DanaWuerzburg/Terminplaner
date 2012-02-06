require 'spec_helper'

describe "appointments/edit" do

  before(:each) do
    @appointment = assign(:appointment, stub_model(Appointment,
      :note => "MyString",
      :priority_number => 1,
      :group => "MyString",
      :user_id => 1,
      :group_id => 1,
      :color => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit appointment form" do
    render

    rendered.should have_selector("form", :action => appointment_path(@appointment), :method => "post") do |form|
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
