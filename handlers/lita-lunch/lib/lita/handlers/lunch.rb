module Lita
  module Handlers
    class Lunch < Handler
      route(/^lunch(?:$|\s(.{1,}))/,
        :lunch,
        help: {
          "lunch"  => "登録されているリストからお店を選びます",
          "lunch GENRE" => "ジャンルに当てはまるお店を選びます(和食/洋食/中華/イタリアン/アジアン/カフェのどれか)"
        }
      )

      RESTRANTS = [
        { name: "吉成", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13032711/", genre: ["和食"], fee: 1200, comment: '今日は魚　身体が魚を欲している時に言って下さい'},
        { name: "おまかせ亭", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13007048/", genre: ["洋食"], fee: 1500, comment: '店員さんが気さく　ランチセットのデザートの種類が豊富'},
        { name: "WINE & GRILL TACT", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13193233/", genre: ["イタリアン"], fee: 1080, comment: 'おしゃれイタリアン　お肉が食べたい時にもおすすめ'},
        { name: "麺屋 たけいち 渋谷邸", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13175067/", genre: ["中華"], fee: 950, comment: 'ラーメン！ラーメン！ラーメン！'},
        { name: "ほの字", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13007031/", genre: ["和食","洋食"], fee: 900, comment: '和洋問わず定食が楽しめる'},
        { name: "BISTRO DE まいど", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13013705/", genre: ["洋食"], fee: 1000, comment: 'みんなだいすき石焼きカレー'},
        { name: "goo ITALIANO", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13133728/", genre: ["イタリアン"], fee: 1000, comment: 'ランチセットでついてくるフォカッチャが美味しい　外国の方もちらほら'},
        { name: "蕎麦きり みよた", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13180620/", genre: ["和食"], fee: 900, comment: '時間によっては並ぶけど美味しい　遠いけど美味しい　丼もある'},
        { name: "やよい軒", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13179148/", genre: ["和食","洋食","中華"], fee: 800, comment: '実は卵焼きが美味しい'},
        { name: "茶鍋カフェ kagurazaka saryo", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13118367/", genre: ["和食"], fee: 900, comment: 'お鍋がベースでうどんかおじやか選べる　ほっこり系'},
        { name: "クアアイナ", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13001358/", genre: ["洋食"], fee: 1080, comment: 'おしゃれバーガー界では一番入りやすいと思われる'},
        { name: "立吉", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13101510/", genre: ["中華"], fee: 1000, comment: '大将でもなく大阪大将でもない今時の餃子屋'},
        { name: "コサリ ニューコリアン テーブル トウキョウ", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13146845/", genre: ["アジアン"], fee: 1000, comment: '石焼きビビンバが食べたいときに'},
        { name: "青学", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13173440/", genre: ["和食","洋食","中華"], fee: 400, comment: '近い・安い'},
        { name: "丸亀製麺", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13112576/", genre: ["和食"], fee: 400, comment: 'うどんといえば丸亀　安くてもちゃんと美味しい'},
        { name: "志味津", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13036585/", genre: ["和食"], fee: 1100, comment: 'とんかつ　かつの種類が豊富でメニュー選びに悩む'},
        { name: "ガパオ食堂", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13041239/", genre: ["アジアン"], fee: 1100, comment: '異国の味　アジアを求めたい時に'},
        { name: "タコベル", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13196315/", genre: ["アジアン"], fee: 850, comment: 'お手軽異国　片手異国　意外とヘルシーなのかも'},
        { name: "糖質制限", tabelog: "http://www.lawson.co.jp/recommend/original/detail/1283496_1996.html", genre: ["ダイエット"], fee: 200, comment: 'いわゆるふすまパン　たまに食べるとおいしい'},
        { name: "ワンディッシュタイ", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13131508/", genre: ["アジアン"], fee: 900, comment: 'カレーやガパオから２種類選べるお得なランチ　お腹もいっぱい'},
        { name: "MOJA in the HOUSE", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13166764/", genre: ["カフェ"], fee:1200 , comment: '広い'},
        { name: "パリヤ", tabelog: "https://tabelog.com/tokyo/A1306/A130602/13007440/", genre: ["和食","洋食","中華","イタリアン","カフェ"], fee: 1100, comment: '選べるデリスタイルのカフェレストラン ドリンクバーとスープ付き'},
        { name: "ＮＡＰＯLＩＭＡＮＩＡ", tabelog: "https://tabelog.com/tokyo/A1303/A130301/13125763/", genre: ["イタリアン"], fee:1000 , comment: 'シェフがイケメンらしい'},
        # { name: "", tabelog: "", genre: [""], fee: , comment: ''},
        # { name: "", tabelog: "", genre: [""], fee: , comment: ''},
        # { name: "", tabelog: "", genre: [""], fee: , comment: ''},
        # { name: "", tabelog: "", genre: [""], fee: , comment: ''},
      ].freeze

      def lunch(response)
        p response.matches
        if response.matches[0][0]
          p response.matches[0][0]
          restrants = RESTRANTS.map{ |restrant| restrant if restrant[:genre].include?(response.matches[0][0]) }.compact
          if restrants.length != 0
            recommend = restrants.sample
          else
            response.reply("それはないみたいな。 和食/洋食/中華/イタリアン/アジアン/カフェ から選んでみて :pizza: \n入力例: > lunch カフェ")
            return
          end
        else
          recommend = RESTRANTS.sample
        end

        response.reply("
          「#{recommend[:name]}」とかどうでしょう？
          -----
          食べログ: #{recommend[:tabelog]}
          ジャンル: #{recommend[:genre].join('/')}
          価格目安: #{recommend[:fee]}
          コメント: #{recommend[:comment]}
          -----
        ")
      end

      Lita.register_handler(self)
    end
  end
end
