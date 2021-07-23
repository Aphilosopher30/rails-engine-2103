class Api::V1::ItemsController < ApplicationController

  def index
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 20).to_i
    pagination = paginate(page, per_page)

    items = Item.all.offset(pagination[:offset]).limit(pagination[:per_page])
    render json: ItemSerializer.new(items)
  end

  def show
    # binding.pry
    item = Item.find_by(id: params[:id])
    if item != nil
      render json: ItemSerializer.new(item)
    else
      error_404
    end

    # item = Item.find_by(id: params[:id])
    # if merchant.nil?
    #   error_404
    # else
    #   render json: ItemSerializer.new(items)
    # end
  end

  def merchant
    item = Item.find_by(id: params[:id])
    if item != nil
      merchant = item.merchant
      render json: MerchantSerializer.new(merchant)
    else
      error_404
    end
  end

  def update
    item = Item.find_by(id: params[:id])
    new_merchant = Merchant.find_by(id: params[:item][:merchant_id])
    if item == nil
      error_404("item does not exist")
    elsif params[:item][:merchant_id] != nil && new_merchant == nil
      error_404("bad merchant id")
    else
      item.update(item_param)
      render json: ItemSerializer.new(item)
    end
  end

  def create
    new_item = Item.create(item_param)
    render json: ItemSerializer.new(new_item), :status => 201
    Item.destroy(new_item.id)
  end

  def find
    item = Item.find_by(name: params[:name])
    if params[:name] == nil
      error_404(["no name provided for the search"])
    elsif item == nil
      find_close_match
    else
      render json: ItemSerializer.new(item)
    end

  end

  def find_close_match
    items = Item.where("lower(name) like ?", "%#{params[:name].downcase}%")
    if items == []
      render json: {id: nil, data: {message: "no items found"}}, :status => 200
    else
      render json: ItemSerializer.new(items.first)
    end
  end

  def find_all
    item = Item.where("lower(name) like ?", "%#{params[:name].downcase}%").order(:name)
    render json: ItemSerializer.new(item)
  end



  private
  def item_param
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
