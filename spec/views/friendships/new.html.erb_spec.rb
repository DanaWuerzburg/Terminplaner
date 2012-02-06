require 'spec_helper'

describe "friendships/new" do
  before(:each) do
    assign(:friendship, stub_model(Friendship,
      :user_id => 1,
      :friend_id => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new friendship form" do
    render

    rendered.should have_selector("form", :action => friendships_path, :method => "post") do |form|
      form.should have_selector("input#friendship_user_id", :name => "friendship[user_id]")
      form.should have_selector("input#friendship_friend_id", :name => "friendship[friend_id]")
      form.should have_selector("input#friendship_status", :name => "friendship[status]")
    end
  end
end
