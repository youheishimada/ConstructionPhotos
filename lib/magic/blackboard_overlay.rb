# lib/magic/blackboard_overlay.rb
require 'mini_magick'

module Magic
  class BlackboardOverlay
    def self.compose(input_path:, output_path:, text_data:)
      image = MiniMagick::Image.open(input_path)

      image.combine_options do |c|
        c.gravity "southwest"
        c.fill "white"
        c.pointsize "32"
        c.draw "text 30,30 '工事番号: #{text_data[:work_number]}'"
        c.draw "text 30,70 '工事内容: #{text_data[:work_content]}'"
        c.draw "text 30,110 '工事箇所: #{text_data[:location]}'"
        c.draw "text 30,150 '撮影日: #{Time.now.strftime('%Y-%m-%d')}'"
      end

      image.write(output_path)
    end
  end
end