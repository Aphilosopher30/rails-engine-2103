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

  def find
    merchant_exact = Merchant.find_by(name: params[:name])
    if params[:name] == nil
      error_404(["no name provided for the search"])
    elsif merchant_exact == nil
      find_close_match
    else
      render json: MerchantSerializer.new(merchant_exact)
    end
  end

  def find_close_match
    merchant = Merchant.where("lower(name) like ?", "%#{params[:name].downcase}%")
    if merchant == []
      render json: {id: nil, data: {message: "no merchants found"}}, :status => 200
    else
      render json: MerchantSerializer.new(merchant.first)
    end
  end

  def find_all
    merchant = Merchant.where("lower(name) like ?", "%#{params[:name].downcase}%").order(:name)
    render json: MerchantSerializer.new(merchant)
  end


  def most_items
    number = params[:quantity]
    if number == nil
      render json: {id: nil, data: {message: "invalid quantity"}, error: "invalid quantity"}, :status => 400
    else
      merchants = Merchant.joins(items: {invoice_items: {invoice: :transactions}})
        .where('invoices.status = ?', "shipped").where('transactions.result = ?', "success")
        .group('merchants.id').select("merchants.*, sum(invoice_items.quantity) as total_count")
        .order(total_count: :desc).limit(number)

      count_list = merchants.map do |merch|
        ItemCount.new(merch.id, merch.total_count)
      end

      render json: MerchantSailsCountSerializer.new(count_list)
    end
  end

end
