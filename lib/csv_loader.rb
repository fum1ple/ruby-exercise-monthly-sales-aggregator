require 'csv'
require 'date'

module CsvLoader
  module_function

  def load_all(file_paths)
    all_data = []

    file_paths.each do |file_path|
      department_name = extract_department_name(file_path)

      CSV.foreach(file_path, headers: true, encoding: 'UTF-8') do |row|
        next if row['日付'].nil? || row['単価'].nil? || row['数量'].nil?

        date = Date.parse(row['日付'].strip)
        item = row['商品名'].to_s.strip
        unit_price = row['単価'].to_i
        quantity = row['数量'].to_i
        amount = row['売上金額'] ? row['売上金額'].to_i : unit_price * quantity
        department = row['部門'] ? row['部門'].to_s.strip : department_name

        all_data << {
          date: date,
          department: department,
          item: item,
          unit_price: unit_price,
          quantity: quantity,
          amount: amount
        }
      end
    end
    return all_data
  end

  def extract_department_name(file_path)
    File.basename(file_path).split('_').first
  end
end
