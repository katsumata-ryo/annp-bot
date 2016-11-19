module Lita
  module Handlers
    class Lunch < Handler
      # insert handler code here
      route /lunch/, :lunch

      RESTRANTS = [
        { name: "店舗1", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "和食", tags: []},
        { name: "店舗2", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "洋食", tags: []},
        { name: "店舗3", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "イタリアン", tags: []},
        { name: "店舗4", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "ラーメン", tags: []},
        { name: "店舗5", tabelog: "https://tabelog.com/kanagawa/A1405/A140507/14000813/", genre: "コンビニ", tags: []},
      ].freeze

      def lunch(response)

        recommend = RESTRANTS.sample
        response.reply("
          lita おすすめのランチは#{recommend[:name]}です！
          食べログ: #{recommend[:tabelog]}
          ジャンル: #{recommend[:genre]}
        ")
      end

      Lita.register_handler(self)
    end
  end
end
