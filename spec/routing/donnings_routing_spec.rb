require "rails_helper"

RSpec.describe DonningsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/donnings").to route_to("donnings#index")
    end

    it "routes to #show" do
      expect(get: "/donnings/1").to route_to("donnings#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/donnings").to route_to("donnings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/donnings/1").to route_to("donnings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/donnings/1").to route_to("donnings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/donnings/1").to route_to("donnings#destroy", id: "1")
    end
  end
end
