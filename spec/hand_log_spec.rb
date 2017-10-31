require "spec_helper"

# standard_kif_spec でいろんなパターンをテストしているのでここでテストするのは基本のメソッドだけでOK
module Bushido
  describe HandLog do
    before do
      @mediator = Mediator.test

      # 初手７六歩
      @hand_log = HandLog.new(point: Point["７六"], piece: Piece["歩"], origin_point: Point["７七"], player: @mediator.black_player)
    end

    it "CPU向けの表記を返す" do
      @hand_log.to_s_simple.should == "7六歩(77)"
    end

    it "人間向けの表記を返す" do
      @hand_log.to_s_human.should == "7六歩"
    end

    it "両方返す" do
      @hand_log.to_pair.should == ["7六歩(77)", "7六歩"]
    end
  end
end
