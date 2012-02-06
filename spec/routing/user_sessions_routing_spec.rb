require "spec_helper"

describe UserSessionsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_sessions").should route_to("user_sessions#index")
    end

    it "routes to #new" do
      get("/user_sessions/new").should route_to("user_sessions#new")
    end

    it "routes to #show" do
      get("/user_sessions/1").should route_to("user_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_sessions/1/edit").should route_to("user_sessions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_sessions").should route_to("user_sessions#create")
    end

    it "routes to #update" do
      put("/user_sessions/1").should route_to("user_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_sessions/1").should route_to("user_sessions#destroy", :id => "1")
    end

  end
end
