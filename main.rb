require_relative 'lib/csv_loader'
require_relative 'lib/sales_aggregator'
require_relative 'output/result_exporter'

data_dir = "data"

file_paths = Dir.glob("#{data_dir}/*_売上.csv")

# CSVを読み込む
sales_data = CsvLoader.load_all(file_paths)

organized_sales_data = SalesAggregator.aggregate(sales_data)

begin
  ResultExporter.export_csv(organized_sales_data)
rescue StandardError => e
  puts "Error exporting CSV: #{e.message}"
  exit 1
end
puts "Sales data has been successfully aggregated and exported."
