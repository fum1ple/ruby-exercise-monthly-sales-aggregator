require_relative 'lib/csv_loader'
require_relative 'lib/sales_aggregator'

data_dir = "data"

file_paths = Dir.glob("#{data_dir}/*_売上.csv")

# CSVを読み込む
sales_data = CsvLoader.load_all(file_paths)

puts SalesAggregator.aggregate(sales_data)
