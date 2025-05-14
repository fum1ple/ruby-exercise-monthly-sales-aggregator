require 'csv'
require 'fileutils'
require 'date'

module ResultExporter
  module_function

  def export_csv(sales_data)
    return if sales_data.empty?

    date_str = sales_data[0][:date]

    year_month = if date_str.is_a?(Date)
      "#{date_str.year}年#{date_str.month}月"
    else
      parts = date_str.split('-')
      "#{parts[0]}年#{parts[1]}月"
    end

    data_dir = File.join(File.expand_path('../..', __FILE__), 'data')

    FileUtils.mkdir_p(data_dir) unless Dir.exist?(data_dir)

    filename = "売上月報_#{year_month}.csv"
    filepath = File.join(data_dir, filename)

    csv_data = CSV.generate(headers: true, encoding: 'UTF-8') do |csv|
      csv << ['年月', '部門', '商品名', '売上金額', '数量']
      sales_data.each do |record|
        csv << [
          record[:date],
          record[:department],
          record[:item],
          record[:total_amount],
          record[:total_quantity]
        ]
      end
    end

    File.write(filepath, csv_data)

    puts "月次売上レポートを出力しました: #{filepath}"
    filepath
  end
end
