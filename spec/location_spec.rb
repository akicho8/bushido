require_relative "spec_helper"

module Bushido
  describe Location do
    it "変換可能" do
      Location[-1].key.should      == :white
      Location[0].key.should       == :black
      Location[1].key.should       == :white
      Location[2].key.should       == :black
      Location[:black].key.should  == :black
      Location["▲"].key.should    == :black
      Location["▼"].key.should    == :black
      Location["b"].key.should     == :black
      Location["先手"].key.should  == :black
      Location["1手目"].key.should == :black
      Location["3"].key.should     == :black
    end

    it "盤面読み取り用" do
      Location[" "].key.should == :black
      Location["^"].key.should == :black
      Location["v"].key.should == :white
    end

    it "変換不能" do
      expect { Location[nil]   }.to raise_error(SyntaxDefact)
      expect { Location[""]    }.to raise_error(SyntaxDefact)
      expect { Location["foo"] }.to raise_error(SyntaxDefact)
    end

    it "簡潔に書きたいとき用" do
      L.b.key.should == :black
      L.w.key.should == :white
    end

    it "次の手番を返す" do
      Location[:white].reverse.key.should == :black
      Location[:white].next_location.key.should == :black
    end

    it "属性っぽい値を全部返す" do
      Location[:black].match_target_values.should be_an_instance_of Array
    end

    it "先手後手を表す文字一覧の正規表現" do
      Location.triangles.should == "▲▼△▽"
    end

    it "cssのstyle" do
      Location[:white].style_transform.should == "transform: rotate(180deg)"
      Location[:black].style_transform.should == nil
    end
  end
end
