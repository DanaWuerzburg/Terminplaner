require 'spec_helper'

describe "Groups" do
  describe "GET /groups" do
    it "works! (now write some real specs)" do
      visit groups_path
      response.status.should be(200)
    end
  end
end
