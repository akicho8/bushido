require_relative "spec_helper"

module Bioshogi
  describe Board do
    it "配置" do
      mediator = Mediator.new

      mediator.board.all_clear
      mediator.placement_from_preset("裸玉")
      assert { mediator.board.preset_info&.key == :"十九枚落ち" }

      mediator.board.all_clear
      mediator.board.placement_from_hash(black: "平手", white: "裸玉")
      assert { mediator.board.preset_info&.key == :"十九枚落ち" }

      mediator.board.all_clear
      mediator.board.placement_from_hash(black: "平手", white: "二十枚落ち")
      mediator.board.placement_from_human("△５一玉")
      assert { mediator.board.preset_info&.key == :"十九枚落ち" }

      mediator.board.all_clear
      mediator.board.placement_from_shape <<~EOT
      +---------------------------+
      | ・ ・ ・ ・v玉 ・ ・ ・ ・|一
      | ・ ・ ・ ・ ・ ・ ・ ・ ・|二
      | ・ ・ ・ ・ ・ ・ ・ ・ ・|三
      | ・ ・ ・ ・ ・ ・ ・ ・ ・|四
      | ・ ・ ・ ・ ・ ・ ・ ・ ・|五
      | ・ ・ ・ ・ ・ ・ ・ ・ ・|六
      | 歩 歩 歩 歩 歩 歩 歩 歩 歩|七
      | ・ 角 ・ ・ ・ ・ ・ 飛 ・|八
      | 香 桂 銀 金 玉 金 銀 桂 香|九
      +---------------------------+
        EOT
      assert { mediator.board.preset_info&.key == :"十九枚落ち" }
    end

    it "サンプル" do
      board = Board.new
      assert { board["５五"] == nil }
    end

    it "指定の座標だけを消す微妙なテスト" do
      Board.dimensiton_change([1, 3]) do
        mediator = Mediator.new
        mediator.player_at(:black).soldier_create("１三香")
        mediator.board.safe_delete_on(Place["１三"])
        assert { mediator.board["１三"] == nil }
      end
    end
  end
end
