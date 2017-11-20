module Bushido
  module Parser
    # CSA標準棋譜ファイル形式
    # http://www.computer-shogi.org/protocol/record_v22.html
    #
    #   V2.2
    #   N+久保利明 王将
    #   N-都成竜馬 四段
    #   $EVENT:王位戦
    #   $SITE:関西将棋会館
    #   $START_TIME:2017/11/16 10:00:00
    #   $END_TIME:2017/11/16 19:04:00
    #   $OPENING:相振飛車
    #
    class HeaderInfo
      include MemoryRecord
      memory_record [
        # CSA側               KIF/KI2 形式
        {key: "N+",           replace_key: "先手",     },
        {key: "N-",           replace_key: "後手",     },
        {key: "$EVENT:",      replace_key: "棋戦",     },
        {key: "$SITE:",       replace_key: "場所",     },
        {key: "$START_TIME:", replace_key: "開始日時", },
        {key: "$END_TIME:",   replace_key: "終了日時", },
        {key: "$OPENING:",    replace_key: "戦型",     },
      ]

      alias csa_key key
    end
  end
end