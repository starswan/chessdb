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

    it "routes to #show" do
      expect(get: "/openings/1").to route_to("openings#show", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/openings/1").to route_to("openings#destroy", id: "1")
    end
  end
end
