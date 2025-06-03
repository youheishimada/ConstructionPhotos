# script/blackboard_test.rb
require_relative '../config/environment'
require_relative '../lib/magic/blackboard_overlay'

Magic::BlackboardOverlay.compose(
  input_path: "test_image.jpg",           # テスト用画像を置いてください
  output_path: "output_image.jpg",        # 出力ファイル
  text_data: {
    work_number: "A-001",
    work_content: "配管工事",
    location: "1F 機械室"
  }
)

puts "✅ 合成画像が output_image.jpg に保存されました"