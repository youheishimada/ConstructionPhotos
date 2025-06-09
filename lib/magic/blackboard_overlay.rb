# lib/magic/blackboard_overlay.rb
module Magic
  class BlackboardOverlay
    def self.compose_overlay(photo_path:, output_path:, text_data:)
      require 'mini_magick'

      # 元写真と黒板テンプレートを読み込み
      photo = MiniMagick::Image.open(photo_path)
      blackboard = MiniMagick::Image.open(Rails.root.join("app/assets/images/blackboard_base.png"))

      # 黒板サイズを写真の幅の約1/3に縮小（高さは自動）
      blackboard.resize "#{(photo.width / 3).to_i}x"

      # 黒板に文字を1行ずつ描画
      blackboard.combine_options do |c|
        c.gravity "NorthWest"
        c.font "app/assets/fonts/ipaexg.ttf"
        c.fill "white"
        c.pointsize (blackboard.height * 0.06).to_i 
        c.font "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc"       
        c.draw "text 10,10 \"年月日: #{text_data[:date]}\""
        c.draw "text 10,20 \"工事番号: #{text_data[:work_number].gsub('-', '－')}\""
        c.draw "text 10,30 \"工事件名: #{text_data[:project_name]}\""
        # --- 複数行の工事内容 ---
        y = 40
        line_height = 10
        text_data[:work_content].to_s.split(/\r?\n/).each do |line|
          c.draw "text 10,#{y} \"#{line}\""
          y += line_height
        end
        # --- 以下も同じように ---
        c.draw "text 10,#{y+10} \"箇所: #{text_data[:location]}\""
        c.draw "text 10,#{y+20} \"施工者: #{text_data[:contractor]}\""
      end

      # 写真に黒板を左下に合成
      result = photo.composite(blackboard) do |c|
        c.gravity "SouthWest"  # 左下に配置
        c.geometry "+10+10"    # 余白を少し空ける
      end

      result.write(output_path)
    end
  end
end