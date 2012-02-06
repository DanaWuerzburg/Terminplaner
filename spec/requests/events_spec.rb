require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    it "works! (now write some real specs)" do
      visit events_path
      response.status.should be(200)
    end
  end
end
