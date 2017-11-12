require_relative "spec_helper"

module Bushido
  describe BaseFormat do
    it "座標がない場合は右上の盤面とする" do
      board_parse_test(<<-BOARD).should == {L.w => ["1一歩"], L.b => ["1二歩"]}
+------+
| ・v歩|
| ・ 歩|
+------+
BOARD
    end

    it "座標の指定があれば任意のエリアを表現できる" do
      board_parse_test(<<-BOARD).should == {L.b => ["8九歩"], L.w => ["8八歩"]}
  ９ ８
+------+
| ・v歩|八
| ・ 歩|九
+------+
BOARD
    end

    it "成駒を認識できる" do
      board_parse_test(<<-BOARD).should == {L.b => [], L.w => ["1一龍"]}
+---+
|v龍|
+---+
BOARD
    end

#     it "盤面サイズを変更していても定義は9x9を元にしているので問題なくパースできる" do
#       Board.size_change([2, 2]) do
#         board_parse_test(<<-BOARD).should == {L.b => ["3一歩"], L.w => []}
# +---------+
# | 歩 ・ ・|
# +---------+
# BOARD
#       end
#     end

    it "盤面の「・」は不要" do
      board_parse_test(<<-BOARD).should == {L.w => ["1一歩"], L.b => ["1二歩"]}
+------+
|   v歩|
|    歩|
+------+
BOARD
    end

    it "先手後手の表現" do
      board_parse_test("+---+\| 金|\n+---+").should == {L.b => ["1一金"], L.w => []}
      board_parse_test("+---+\|^金|\n+---+").should == {L.b => ["1一金"], L.w => []}
      board_parse_test("+---+\|v金|\n+---+").should == {L.b => [],        L.w => ["1一金"]}
    end

#     describe "あえて緩くしている部分" do
#       it "座標の名前のチェックなし" do
#         board_parse_test(<<-BOARD).should == {L.b => ["AY歩"], L.w => ["AX歩"]}
#   B  A
# +------+
# | ・v歩|X
# | ・ 歩|Y
# +------+
# BOARD
#       end
#     end

    describe "エラー" do
      it "駒がおかしい" do
        expect { board_parse_test("+---+\| ★|\n+---+") }.to raise_error(SyntaxError, /駒の指定が違います/)
      end

      it "横幅が3桁毎になっていません" do
        expect { board_parse_test(<<-BOARD) }.to raise_error(SyntaxError, /横幅が3桁毎になっていません/)
+--+
|歩|
+--+
BOARD
      end
    end
  end
end
