require 'spec_helper'

describe "Appointments" do
  describe "GET /appointments" do
    it "works! (now write some real specs)" do
      visit appointments_path
      response.status.should be(200)
    end
  end
end
