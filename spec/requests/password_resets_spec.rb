require 'spec_helper'

describe "PasswordResets" do
  describe "GET /password_resets" do
    it "works! (now write some real specs)" do
      visit password_resets_path
      response.status.should be(200)
    end
  end
end
