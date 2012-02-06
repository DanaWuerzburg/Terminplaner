require 'spec_helper'

describe "groups/index" do
  before(:each) do
    assign(:groups, [
      stub_model(Group,
        :name => "Name",
        :description => "Description",
        :color => "Color",
        :user_id => 1
      ),
      stub_model(Group,
        :name => "Name",
        :description => "Description",
        :color => "Color",
        :user_id => 1
      )
    ])
  end

  it "renders a list of groups" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Description".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Color".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
