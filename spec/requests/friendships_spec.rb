require 'spec_helper'

describe "Friendships" do
  describe "GET /friendships" do
    it "works! (now write some real specs)" do
      visit friendships_path
      response.status.should be(200)
    end
  end
end
