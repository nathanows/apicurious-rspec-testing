require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe '#index' do
    it "responds with success" do
      get :index, format: :json
      expect(response.status).to eq(200)
    end

    it "responds with items" do
      item = create(:item, name: "Purple Drank", description: "Just a purple beverage")
      create(:item)
      get :index, format: :json

      items = JSON.parse(response.body)
      first_item = items.first

      expect(items.count).to eq(2)
      expect(first_item["id"]).to eq(item.id)
      expect(first_item["name"]).to eq("Purple Drank")
      expect(first_item["description"]).to eq("Just a purple beverage")
    end
  end

  describe '#show' do
    it "responds with success" do
      item = create(:item)
      get :show, format: :json, id: item.id
      expect(response.status).to eq(200)
    end

    it "responds with items" do
      item = create(:item, name: "Purple Drank", description: "Just a purple beverage")
      create(:item)
      get :show, format: :json, id: item.id

      returned_item = JSON.parse(response.body)

      expect(returned_item["id"]).to eq(item.id)
      expect(returned_item["name"]).to eq("Purple Drank")
      expect(returned_item["description"]).to eq("Just a purple beverage")
    end
  end

  describe '#create' do
    it "responds with success" do
      post :create, format: :json, item: {name: 'Cow', description: 'This is a cow.'}
      expect(response.status).to eq(200)
    end

    it "creates the item and returns the completed item with success msg" do
      post :create, format: :json, item: {name: 'Cow', description: 'This is a cow.'}

      create_response = JSON.parse(response.body)
      item = create_response["item"]
      message = create_response["message"]

      expect(Item.count).to eq(1)
      expect(message).to eq("Item created!")
      expect(item["name"]).to eq("Cow")
      expect(item["description"]).to eq("This is a cow.")
    end
  end

  describe '#update' do
    it "responds with success" do
      item = create(:item)
      put :update, id: item.id, format: :json, item: {name: 'Cow', description: 'This is a cow.'}
      expect(response.status).to eq(200)
    end

    it "creates the item and returns the completed item with success msg" do
      item = create(:item, name: "Original", description: "Old description.")
      put :update, id: item.id, format: :json, item: {name: 'Cow', description: 'This is a cow.'}

      create_response = JSON.parse(response.body)
      item = create_response["item"]
      message = create_response["message"]

      expect(Item.count).to eq(1)
      expect(message).to eq("Item updated!")
      expect(item["name"]).to eq("Cow")
      expect(item["description"]).to eq("This is a cow.")
    end
  end
end
