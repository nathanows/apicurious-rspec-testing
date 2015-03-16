class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |format|
        format.json { render json: { message: "Item created!", item: @item } }
        format.xml { render xml: { message: "Item created!", item: @item } }
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Item not created!", errors: @item.errors } }
        format.xml { render xml: { message: "Item not created!", errors: @item.errors } }
      end
    end
  end

  def update
    @item = Item.find_by(id: params[:id])
    if @item.update(item_params)
      respond_to do |format|
        format.json { render json: { message: "Item updated!", item: @item } }
        format.xml { render xml: { message: "Item updated!", item: @item } }
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Item not updated!", errors: @item.errors } }
        format.xml { render xml: { message: "Item not updated!", errors: @item.errors } }
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
