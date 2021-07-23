class Api::V1::RevenuesController < ApplicationController



  def merchant
    merchant = Merchant.find_by(id: params[:id])
    if merchant == nil
      error_404
    else
      revenue = merchant.invoices.where('invoices.status = ?', "shipped")
      .sum('invoice_items.quantity*invoice_items.unit_price')

      revenue_object = Revenue.new(merchant.id, revenue)
      render json: MerchantRevenueSerializer.new(revenue_object)
    end
  end

  def most_profitable
    number = params[:quantity]
    if number == nil
      render json: {id: nil, data: {message: "invalid quantity"}, error: "invalid quantity"}, :status => 400
    else

    merchants = Merchant.joins(items: {invoice_items: {invoice: :transactions}})
      .where('invoices.status = ?', "shipped").where('transactions.result = ?', "success")
      .group('merchants.id').select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue")
      .order(total_revenue: :desc).limit(number)

    revenue_list = merchants.map do |merch|
      Revenue.new(merch.id, merch.total_revenue)
    end

    render json: MerchantNameRevenueSerializer.new(revenue_list)
    end
  end
end
