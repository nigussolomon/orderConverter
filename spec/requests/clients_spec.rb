# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Clients", type: :request do
  describe "GET /index" do
    it "returns success response" do
      create(:client)
      get "/clients"
      result = JSON(response.body)
      expect(response).to be_successful
      expect(result["success"]).to be_truthy
    end
  end
end
