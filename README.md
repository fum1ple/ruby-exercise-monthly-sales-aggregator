# ruby-exercise-monthly-sales-aggregator

## 達成したいことと要件定義
### 達成したいこと
- 複数部門の売上データをまとめたい
- 月次売上合計や平均単価を計算して、レポートをテーブル形式で出力したい
### 要件定義
- csvファイルを読み込む
  - 部門ごとに分かれたCSVファイルを読み込む

- 月次の集計処理をする
  - 日付から月を抽出する `（YYYY-MM）`
  - 部門×月単位で以下の指標を集計
    - 総売上金額：　部門内の売上合計
    - 販売数量合計：　部門内の数量合計
    - 平均単価：　総売上金額 / 販売数量合計（小数第1位まで）
  - 結果をテーブルにまとめる

- テーブル出力（結果の整形）
  - コンソールで表示するか、新しくcsvを出力するか
  - 出力カラム
    - 月
    - 部門
    - 総売上金額
    - 販売数量合計
    - 平均単価

## 設計（テストケース含めて）
```
📂project_root/
├── main.rb                 # 実行するメインファイル
├── lib/
│   ├── csv_loader.rb       # CSV読み込み・前処理
│   ├── sales_aggregator.rb # 月次集計
│   ├── result_exporter.rb  # 結果出力（CSV or コンソール）
├── data/
│   ├── 食品部門_売上.csv
│   ├── 衣料部門_売上.csv
│   └── 家電部門_売上.csv
└── output/
    └── monthly_summary.csv
```
### csv_loader.rb
- 入力
  - ファイルパスでよみこむ
- 出力
  - 売上データの配列
  例：　`{ date: "2025-05-01", department: "食品部門", item: "パン", unit_price: 150, quantity: 20, amount: 3000 }`
- 処理
  - csvファイルをループ
  - 1行ずつ読み込む
  - パースしながら値を変換/補完
### sales_aggregator.rb
- 入力
  - レコードからmonth `"2025-05"`を抽出
  - `[month, department]`でハッシュ化する
  - 各グループで値計算する
    - `total_amount`：　amount合計
    - `total_quantity`：　quantityの合計
    - `average_unit_price`：　total_amount / total_quantity
### result_exporter.rb
- 結果をコンソールかcsv出力する
  - メソッドで分ける
    - .to_csv
    - .to_console