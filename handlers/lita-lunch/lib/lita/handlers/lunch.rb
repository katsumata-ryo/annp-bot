module Lita
  module Handlers
    class Lunch < Handler
      route /^lunch(?:$|\s(.{1,}))/, :lunch

      RESTRANTS = [
        { name: "吉成", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13032711/", genre: "和食", tags: []},
        { name: "おまかせ亭", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13007048/", genre: "洋食", tags: []},
        { name: "WINE & GRILL TACT", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13193233/", genre: "イタリアン", tags: []},
        { name: "麺屋 たけいち 渋谷邸", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13175067/", genre: "ラーメン", tags: []},
        { name: "ナチュラルローソン", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13165025/", genre: "コンビニ", tags: []},
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
      ].freeze

      def lunch(response)
        p response.matches
        case response.matches[0][0]
        when 'cafe'
          recommend = CAFE.sample
        when nil
          recommend = RESTRANTS.sample
        else
          response.reply("それはない")
          return
        end

        response.reply("
          「#{recommend[:name]}」とかどうでしょう？
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
