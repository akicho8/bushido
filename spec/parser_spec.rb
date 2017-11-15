require_relative "spec_helper"

module Bushido
  describe Parser do
    it "ヘッダー行のセパレータは全角セミコロン" do
      Parser.parse("a：b").header.should == {"a" => "b"}
      Parser.parse("a:b：c").header.should == {"a:b" => "c"}
    end

    it "ヘッダー行のセパレータに半角を含めると時間の部分のセミコロンと衝突するので対応しない" do
      Parser.parse("a:b").header.should_not == {"a" => "b"}
    end

    it "日時の場合正規化する" do
      Parser.parse("開始日時：2000-1-1  1:23:45").header.should == {"開始日時" => "2000/01/01 01:23:45"}
      Parser.parse("終了日時：2000/1/1 01:23:45").header.should == {"終了日時" => "2000/01/01 01:23:45"}
    end
  end
end