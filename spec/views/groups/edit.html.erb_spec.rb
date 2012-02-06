require 'spec_helper'

describe "groups/edit" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :name => "MyString",
      :description => "MyString",
      :color => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit group form" do
    render

    rendered.should have_selector("form", :action => group_path(@group), :method => "post") do |form|
      form.should have_selector("input#group_name", :name => "group[name]")
      form.should have_selector("input#group_description", :name => "group[description]")
      form.should have_selector("input#group_color", :name => "group[color]")
      form.should have_selector("input#group_user_id", :name => "group[user_id]")
    end
  end
end
