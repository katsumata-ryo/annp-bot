module Lita
  module Handlers
    class Yokohama < Handler
      route(/^yokohama\s{1,}cafe/,
        :cafe,
        help: {
          "yokohama cafe"  => "登録している横浜のカフェをだすよー",
        }
      )

      CAFE = [
         { name: "Orientar Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140101/14003211/", genre: "yokohama", tags: [] },
         { name: "Gingers Beach", tabelog: "https://tabelog.com/kanagawa/A1401/A140212/14014714/", genre: "yokohama", tags: [] },
         { name: "Lu's Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140101/14003371/", genre: "yokohama", tags: [] },
         { name: "Roku Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140101/14011201/", genre: "yokohama", tags: [] },
         { name: "24/7 restrant", tabelog: "https://tabelog.com/kanagawa/A1401/A140103/14044853/", genre: "yokohama", tags: [] },
         { name: "BUKATSUDO", tabelog: "https://tabelog.com/kanagawa/A1401/A140103/14056122/", genre: "yokohama", tags: [] },
         { name: "Clever Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140102/14051539/", genre: "yokohama", tags: [] },
         { name: "Branch Kitchen", tabelog: "https://tabelog.com/kanagawa/A1404/A140402/14050545/", genre: "yokohama", tags: [] },
       ].freeze

       RAMEN = [""].freeze

      def cafe(response)
        recommend = CAFE.sample
        message = (
          "「#{recommend[:name]}」とかどうでしょう:question:
          -----
          URL: #{recommend[:url]}
          ジャンル: #{recommend[:genre]}
          -----").gsub(' ', '')
        response.reply(message)
      end

      Lita.register_handler(self)
    end
  end
end
