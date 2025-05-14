require 'date'

module SalesAggregator
  module_function

  def aggregate(sales_data)
    year_month = sales_data[0][:date].strftime("%Y-%m")
    tmp_sales_data = sales_data.group_by { |record| {'date' => record[:date], 'department' => record[:department], 'item' => record[:item]} }
    organized_sales_data = []

    tmp_sales_data.each do |key, records|
      total_amount = 0
      total_quantity = 0

      records.each do |record|
        total_amount += record[:amount]
        total_quantity += record[:quantity]
      end

      organized_sales_data << {
        department: key['department'],
        item: key['item'],
        total_amount: total_amount,
        total_quantity: total_quantity,
        date: year_month,
      }
    end

    return organized_sales_data
  end
end
