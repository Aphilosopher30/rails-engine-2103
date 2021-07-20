class Api::V1::MerchantsController < ApplicationController

  def index

    # binding.pry
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, 20).to_i
    pagination = paginate(page, per_page)

    merchants = Merchant.all.offset(pagination[:offset]).limit(pagination[:per_page])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find_by(id: params[:id])
    if merchant.nil?
      render json: {}, :status => 404
    else
      render json: MerchantSerializer.new(merchant)
      # {"id" => params[:id].to_s, "type" => "merchant","attributes" => {"name" => merchant.name}} #
    end
  end


  def paginate(page, per_page)
    if page.class != Integer || page < 1
      page = 1
    end
    if per_page.class != Integer
      per_page = 20
    end
    offset = per_page*(page-1)
    {offset: offset, per_page: per_page}
  end


end
