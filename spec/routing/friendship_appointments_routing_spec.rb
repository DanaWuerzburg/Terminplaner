require "spec_helper"

describe FriendshipAppointmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/friendship_appointments").should route_to("friendship_appointments#index")
    end

    it "routes to #new" do
      get("/friendship_appointments/new").should route_to("friendship_appointments#new")
    end

    it "routes to #show" do
      get("/friendship_appointments/1").should route_to("friendship_appointments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/friendship_appointments/1/edit").should route_to("friendship_appointments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/friendship_appointments").should route_to("friendship_appointments#create")
    end

    it "routes to #update" do
      put("/friendship_appointments/1").should route_to("friendship_appointments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/friendship_appointments/1").should route_to("friendship_appointments#destroy", :id => "1")
    end

  end
end
