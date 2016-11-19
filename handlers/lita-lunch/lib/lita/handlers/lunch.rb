module Lita
  module Handlers
    class Lunch < Handler
      # insert handler code here
      route /lunch/, :lunch
      route /cafe/, :cafe

      RESTRANTS = [
        { name: "店舗1", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "和食", tags: []},
        { name: "店舗2", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "洋食", tags: []},
        { name: "店舗3", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "イタリアン", tags: []},
        { name: "店舗4", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "ラーメン", tags: []},
        { name: "店舗5", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "コンビニ", tags: []},
      ].freeze

      CAFE = [
        { name: "Orientar Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140101/14003211/", genre: "yokohama", tags: [] },
        { name: "Gingers Beach", tabelog: "https://tabelog.com/kanagawa/A1401/A140212/14014714/", genre: "yokohama", tags: [] },
        { name: "Lu's Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140101/14003371/", genre: "yokohama", tags: [] },
        { name: "Roku Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140101/14011201/", genre: "yokohama", tags: [] },
        { name: "24/7 restrant", tabelog: "https://tabelog.com/kanagawa/A1401/A140103/14044853/", genre: "yokohama", tags: [] },
        { name: "BUKATSUDO", tabelog: "https://tabelog.com/kanagawa/A1401/A140103/14056122/", genre: "yokohama", tags: [] },
        { name: "Clever Cafe", tabelog: "https://tabelog.com/kanagawa/A1401/A140102/14051539/", genre: "yokohama", tags: [] },
        { name: "スターバックス 御成町", tabelog: "https://tabelog.com/kanagawa/A1404/A140402/14003447/", genre: "kamakura", tags: [] },
        { name: "SJO COFFEE", tabelog: "https://tabelog.com/kanagawa/A1404/A140402/14055444/", genre: "kamakura", tags: [] },
        { name: "Branch Kitchen", tabelog: "https://tabelog.com/kanagawa/A1404/A140402/14050545/", genre: "yokohama", tags: [] },
      ]

      def lunch(response)
        recommend = RESTRANTS.sample
        response.reply("
          #{recommend[:name]} とかどうでしょう？
          -----
          食べログ: #{recommend[:tabelog]}
          ジャンル: #{recommend[:genre]}
          -----
        ")
      end

      def cafe
        recommend = CAFE.sample
        response.reply("
          #{recommend[:name]} とかどうでしょう？
          -----
          食べログ: #{recommend[:tabelog]}
          ジャンル: #{recommend[:genre]}
          -----
        ")
      end

      Lita.register_handler(self)
    end
  end
end