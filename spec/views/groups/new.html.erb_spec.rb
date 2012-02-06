require 'spec_helper'

describe "groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :name => "MyString",
      :description => "MyString",
      :color => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new group form" do
    render

    rendered.should have_selector("form", :action => groups_path, :method => "post") do |form|
      form.should have_selector("input#group_name", :name => "group[name]")
      form.should have_selector("input#group_description", :name => "group[description]")
      form.should have_selector("input#group_color", :name => "group[color]")
      form.should have_selector("input#group_user_id", :name => "group[user_id]")
    end
  end
end
