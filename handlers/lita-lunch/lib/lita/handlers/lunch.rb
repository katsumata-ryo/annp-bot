module Lita
  module Handlers
    class Lunch < Handler
      route /^lunch(?:$|\s(.{1,}))/, :lunch

      RESTRANTS = [
        { name: "吉成", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13032711/", genre: "和食", fee: 1, comment: 'test comment'},
        { name: "おまかせ亭", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13007048/", genre: "洋食", fee: 1, comment: 'test comment'},
        { name: "WINE & GRILL TACT", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13193233/", genre: "イタリアン", fee: 1, comment: 'test comment'},
        { name: "麺屋 たけいち 渋谷邸", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13175067/", genre: "ラーメン", fee: 1, comment: 'test comment'},
        { name: "ナチュラルローソン", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13165025/", genre: "コンビニ", fee: 1, comment: 'test comment'},
        { name: "ほの字", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13007031/", genre: "定食", fee: 1, comment: 'test comment'},
        { name: "BISTRO DE まいど", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13013705/", genre: "洋食", fee: 1, comment: 'test comment'},
      ].freeze

      def lunch(response)
        p response.matches
        if response.matches[0][0]
          restrants = RESTRANTS.map{|restrant| restrant if restrant[:genre] == response.matches[0][0] }.compact
          if restrants.length != 0
            recommend = restrants.sample
          else
            response.reply("そのデータはないっぽいです")
            return
          end
        else
          recommend = RESTRANTS.sample
        end

        response.reply("
          「#{recommend[:name]}」とかどうでしょう？
          -----
          食べログ: #{recommend[:tabelog]}
          ジャンル: #{recommend[:genre]}
          価格目安: #{recommend[:fee]}
          コメント: #{recommend[:comment]}
          -----
        ")
      end

      Lita.register_handler(self)
    end
  end
end
