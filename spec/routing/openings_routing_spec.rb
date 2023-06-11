# frozen_string_literal: true
#
# $Id$
#
require "rails_helper"

RSpec.describe OpeningsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/openings").to route_to("openings#index")
    end

    it "routes to #new" do
      expect(get: "/openings/new").to route_to("openings#new")
    end

    it "routes to #show" do
      expect(get: "/openings/1").to route_to("openings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/openings/1/edit").to route_to("openings#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/openings").to route_to("openings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/openings/1").to route_to("openings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/openings/1").to route_to("openings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/openings/1").to route_to("openings#destroy", id: "1")
    end
  end
end
