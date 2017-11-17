require_relative "../spec_helper"

module Bushido
  describe Parser::Base do
    describe "各種フォーマットへの変換" do
      before do
        @info = Parser.parse(<<~EOT)
        場所：(場所)
        先手：(先手)
        後手：(後手)
        ▲７六歩 ▽４二銀 ▲２六歩 ▽５四歩 ▲２五歩 ▽５三銀 ▲２四歩 ▽同　歩 ▲５六歩 ▽３二金
        EOT
      end

      it "to_kif" do
        @info.to_kif.should == <<~EOT
場所：(場所)
先手：(先手)
後手：(後手)
手数----指手---------消費時間--
   1 ７六歩(77)   (00:00/00:00:00)
   2 ４二銀(31)   (00:00/00:00:00)
   3 ２六歩(27)   (00:00/00:00:00)
   4 ５四歩(53)   (00:00/00:00:00)
   5 ２五歩(26)   (00:00/00:00:00)
   6 ５三銀(42)   (00:00/00:00:00)
   7 ２四歩(25)   (00:00/00:00:00)
   8 ２四歩(23)   (00:00/00:00:00)
   9 ５六歩(57)   (00:00/00:00:00)
  10 ３二金(41)   (00:00/00:00:00)
  11 投了
EOT
      end

      it "to_ki2" do
        @info.to_ki2.should == <<~EOT
場所：(場所)
先手：(先手)
後手：(後手)

▲７六歩 ▽４二銀 ▲２六歩 ▽５四歩 ▲２五歩 ▽５三銀 ▲２四歩 ▽同　歩 ▲５六歩 ▽３二金
まで10手で後手の勝ち
EOT
      end

      it "to_csa" do
        @info.to_csa.should == <<~EOT
V2.2
N+(先手)
N-(後手)
$SITE:(場所)
P1-KY-KE-GI-KI-OU-KI-GI-KE-KY
P2 * -HI *  *  *  *  * -KA * 
P3-FU-FU-FU-FU-FU-FU-FU-FU-FU
P4 *  *  *  *  *  *  *  *  * 
P5 *  *  *  *  *  *  *  *  * 
P6 *  *  *  *  *  *  *  *  * 
P7+FU+FU+FU+FU+FU+FU+FU+FU+FU
P8 * +KA *  *  *  *  * +HI * 
P9+KY+KE+GI+KI+OU+KI+GI+KE+KY
+
+7677FU
-4231GI
+2627FU
-5453FU
+2526FU
-5342GI
+2425FU
-2423FU
+5657FU
-3241KI
%TORYO
EOT
      end
    end
  end
end
