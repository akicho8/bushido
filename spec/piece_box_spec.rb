require_relative "spec_helper"

module Bioshogi
  describe PieceBox do
    it "いろんなものに変換" do
      piece_box = PieceBox.new(Piece.s_to_h("飛玉角角"))
      assert { piece_box.to_sfen(:black) == "RK2B" }
      assert { piece_box.to_csa(:black) == "P+00OU00HI00KA00KA" }
      assert { piece_box.to_s(separator: "/") == "玉/飛/角二" }
      assert { piece_box.score == 45880 }
    end

    it "内容が同じなら同じオブジェクトする" do
      a = PieceBox.new(Piece.s_to_h("飛玉"))
      b = PieceBox.new(Piece.s_to_h("玉飛"))
      assert { (a == b) == true }
    end

    it "引数のハッシュは破壊されない" do
      hash = {:king => 1}.freeze
      piece_box = PieceBox.new(hash)
      piece_box.add(king: 1)
      assert { piece_box == {:king => 2} }
      assert { hash      == {:king => 1} }
    end

    it "すべての駒が入っている" do
      assert { PieceBox.all_in_create == {king: 2, rook: 2, bishop: 2, gold: 4, silver: 4, knight: 4, lance: 4, pawn: 18} }
    end

    it "駒を+1して-1したら駒はなくなっている" do
      piece_box = PieceBox.new
      assert { piece_box.exist?(:king) == false }
      piece_box.add(king: 1)
      assert { piece_box.exist?(:king) == true }
      piece_box.add(king: -1)
      assert { piece_box.exist?(:king) == false }
    end

    it "駒がないのに減らしたらエラー" do
      piece_box = PieceBox.new
      proc { piece_box.add(king: -1) }.should raise_error(HoldPieceNotFound)
    end
  end
end
