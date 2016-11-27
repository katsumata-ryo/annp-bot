module Lita
  module Handlers
    class Yokohama < Handler
      route(
        /^yokohama$/,
        :usage,
        help: { "yokohama" => "YOKOHAMAコマンドのヘルプを表示" }
      )
      route(
        /^yokohama\s{1,}cafe/,
        :cafe,
        help: { "yokohama cafe" => "登録している横浜のカフェをだすよー" }
      )
      route(
        /^yokohama\s{1,}ramen/,
        :ramen,
        help: { "yokohama ramen" => "登録している横浜のラーメンをだすよー" }
      )

      CAFE = [
         { name: "Oriental Cafe", url: "https://tabelog.com/kanagawa/A1401/A140101/14003211/", fee: 500, tags: ["ランチ"] },
         { name: "Gingers Beach", url: "https://tabelog.com/kanagawa/A1401/A140212/14014714/", fee: 500, tags: ["ランチ", "ハワイアン"] },
         { name: "Lu's Cafe", url: "https://tabelog.com/kanagawa/A1401/A140101/14003371/", fee: 500, tags: ["ランチ", "遠い"] },
         { name: "Roku Cafe", url: "https://tabelog.com/kanagawa/A1401/A140101/14011201/", fee: 500, tags: ["ランチ"] },
         { name: "24/7 restrant", url: "https://tabelog.com/kanagawa/A1401/A140103/14044853/", fee: 500, tags: ["夜", "混む"] },
         { name: "BUKATSUDO", url: "https://tabelog.com/kanagawa/A1401/A140103/14056122/", fee: 500, tags: ["コーヒーのみ", "コワーキング"] },
         { name: "Clever Cafe", url: "https://tabelog.com/kanagawa/A1401/A140102/14051539/", fee: 500, tags: ["ランチ", "おしゃれ"] },
         { name: "Branch Kitchen", url: "https://tabelog.com/kanagawa/A1404/A140402/14050545/", fee: 500, tags: ["ランチ", "おしゃれ"] },
       ].freeze

       RAMEN = [
         { name: "本丸亭", url: "https://tabelog.com/kanagawa/A1401/A140101/14049658/", fee: 850, tags: ["塩", "平打"] },
         { name: "吉村家", url: "https://tabelog.com/kanagawa/A1401/A140101/14000059/", fee: 630, tags: ["家系", "並ぶ"] },
         { name: "壱八家", url: "https://tabelog.com/kanagawa/A1401/A140101/14000079/", fee: 650, tags: ["家系"] },
         { name: "麺場 浜虎", url: "https://tabelog.com/kanagawa/A1401/A140101/14000361/", fee: 700, tags: ["つけ麺", "塩"] },
         { name: "維新商店", url: "https://tabelog.com/kanagawa/A1401/A140101/14051850/", fee: 690, tags: ["醤油", "安い"] },
         { name: "AFURI横浜", url: "https://tabelog.com/kanagawa/A1401/A140101/14058914/", fee: 880, tags: ["物足りない"] },
         { name: "鶴一家", url: "https://tabelog.com/kanagawa/A1401/A140101/14035352/", fee: 700, tags: ["家系"] },
         { name: "ゴル麺。", url: "https://tabelog.com/kanagawa/A1401/A140101/14038854/", fee: 880, tags: ["家系"] },
         { name: "くり山", url: "https://tabelog.com/kanagawa/A1401/A140205/14012001/", fee: 880, tags: ["白楽"] },
         { name: "自家製麺 SHIN", url: "https://tabelog.com/kanagawa/A1401/A140205/14050343/", fee: 750, tags: ["反町"] },
       ].freeze

      def cafe(response)
        response.reply(build_message(CAFE.sample))
      end

      def ramen(response)
        response.reply(build_message(RAMEN.sample))
      end

      def usage(response)
        message = (
        "横浜に関する情報を表示します。

        ■cafe [ > yokohama cafe ]
        横浜のカフェを一つ提案します。

        ■ramen [ > yokohama cafe ]
        横浜のラーメン店を一つ提案します。"
        ).gsub(/( {2,}|　)/, "\s")

        response.reply(message)
      end

      Lita.register_handler(self)

      private

      def build_message(recommend)
        "「#{recommend[:name]}」とかどうでしょう:question:
        -----
        URL: #{recommend[:url]}
        価格目安: #{recommend[:fee]}
        タグ: #{recommend[:tags].join("/")}
        -----".gsub(/( {2,}|　)/, "\s")
      end
    end
  end
end
