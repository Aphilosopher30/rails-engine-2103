class Api::V1::MerchantsController < ApplicationController

  def index

    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 20).to_i
    pagination = paginate(page, per_page)

    merchants = Merchant.all.offset(pagination[:offset]).limit(pagination[:per_page])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find_by(id: params[:id])
    if merchant.nil?
      error_404
    else
      render json: MerchantSerializer.new(merchant)
      # {"id" => params[:id].to_s, "type" => "merchant","attributes" => {"name" => merchant.name}} #
    end
  end

  def items
    merchant = Merchant.find_by(id: params[:id])
    if merchant == nil
      error_404
    else
      items = merchant.items
      render json: ItemSerializer.new(items)
    end
  end

  def error_404
    render json: {"data" => {}}, :status => 404
  end


end
