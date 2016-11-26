module Lita
  module Handlers
    class Lunch < Handler
      route /^lunch(?:$|\s(.{1,}))/, :lunch

      RESTRANTS = [
        { name: "吉成", url: "https://tabelog.com/tokyo/A1303/A130301/13032711/", genre: ["和食"], fee: 1200, comment: '今日は魚　身体が魚を欲している時にいくといいよ'},
        { name: "おまかせ亭", url: "https://tabelog.com/tokyo/A1303/A130301/13007048/", genre: ["洋食"], fee: 1500, comment: '店員さんが気さく　ランチセットのデザートの種類が豊富'},
        { name: "WINE & GRILL TACT", url: "https://tabelog.com/tokyo/A1303/A130301/13193233/", genre: ["イタリアン"], fee: 1080, comment: 'おしゃれイタリアン　お肉が食べたい時にもおすすめ'},
        { name: "麺屋 たけいち 渋谷邸", url: "https://tabelog.com/tokyo/A1303/A130301/13175067/", genre: ["中華"], fee: 950, comment: 'ラーメン！ラーメン！ラーメン！'},
        { name: "ほの字", url: "https://tabelog.com/tokyo/A1303/A130301/13007031/", genre: ["和食","洋食"], fee: 900, comment: '和洋問わず定食が楽しめるよ'},
        { name: "BISTRO DE まいど", url: "https://tabelog.com/tokyo/A1303/A130301/13013705/", genre: ["洋食"], fee: 1000, comment: 'みんなだいすき石焼きカレー！'},
        { name: "goo ITALIANO", url: "https://tabelog.com/tokyo/A1303/A130301/13133728/", genre: ["イタリアン"], fee: 1000, comment: 'ランチセットでついてくるフォカッチャが美味しい　外国の方もちらほら'},
        { name: "蕎麦きり みよた", url: "https://tabelog.com/tokyo/A1306/A130602/13180620/", genre: ["和食"], fee: 900, comment: '時間によっては並ぶけど美味しい　遠いけど美味しい　丼もある'},
        { name: "やよい軒", url: "https://tabelog.com/tokyo/A1306/A130602/13179148/", genre: ["和食","洋食","中華"], fee: 800, comment: '実は卵焼きが美味しい'},
        { name: "茶鍋カフェ kagurazaka saryo", url: "https://tabelog.com/tokyo/A1303/A130301/13118367/", genre: ["和食"], fee: 900, comment: 'お鍋がベースでうどんかおじやか選べるよ　ほっこり系'},
        { name: "クアアイナ", url: "https://tabelog.com/tokyo/A1303/A130301/13001358/", genre: ["洋食","こーよー"], fee: 1080, comment: 'おしゃれバーガー界では一番入りやすいと思われる'},
        { name: "立吉", url: "https://tabelog.com/tokyo/A1306/A130602/13192814/", genre: ["中華"], fee: 1000, comment: '大将でもなく大阪大将でもない今時の餃子屋さん'},
        { name: "コサリ ニューコリアン テーブル トウキョウ", url: "https://tabelog.com/tokyo/A1306/A130602/13146845/", genre: ["アジアン"], fee: 1000, comment: '石焼きビビンバが食べたいときに'},
        { name: "青学", url: "https://tabelog.com/tokyo/A1303/A130301/13173440/", genre: ["和食","洋食","中華"], fee: 400, comment: '近い！安い！'},
        { name: "丸亀製麺", url: "https://tabelog.com/tokyo/A1306/A130602/13112576/", genre: ["和食"], fee: 400, comment: 'うどんといえば丸亀　安くてもちゃんと美味しい'},
        { name: "志味津", url: "https://tabelog.com/tokyo/A1306/A130602/13036585/", genre: ["和食"], fee: 1100, comment: 'とんかつ　かつの種類が豊富でメニュー選びに悩む'},
        { name: "ガパオ食堂", url: "https://tabelog.com/tokyo/A1303/A130301/13041239/", genre: ["アジアン"], fee: 1100, comment: '異国の味　アジアを求めたい時に'},
        { name: "タコベル", url: "https://tabelog.com/tokyo/A1306/A130602/13196315/", genre: ["アジアン"], fee: 850, comment: 'お手軽異国　片手異国　意外とヘルシーなのかも'},
        { name: "糖質制限", url: "http://www.lawson.co.jp/recommend/original/detail/1283496_1996.html", genre: ["ダイエット"], fee: 200, comment: 'いわゆるふすまパン　たまに食べるとおいしい'},
        { name: "ワンディッシュタイ", url: "https://tabelog.com/tokyo/A1303/A130301/13131508/", genre: ["アジアン"], fee: 900, comment: 'カレーやガパオから２種類選べるお得なランチ　お腹もいっぱい'},
        { name: "MOJA in the HOUSE", url: "https://tabelog.com/tokyo/A1303/A130301/13166764/", genre: ["カフェ","イタリアン"], fee:1200 , comment: '広い'},
        { name: "パリヤ", url: "https://tabelog.com/tokyo/A1306/A130602/13007440/", genre: ["和食","洋食","中華","イタリアン","カフェ"], fee: 1100, comment: '選べるデリスタイルのカフェレストラン ドリンクバーとスープ付き'},
        { name: "ＮＡＰＯLＩＭＡＮＩＡ", url: "https://tabelog.com/tokyo/A1303/A130301/13125763/", genre: ["イタリアン"], fee:1000 , comment: 'シェフがイケメンらしい'},
        { name: "東京ライス", url: "https://tabelog.com/tokyo/A1306/A130602/13139600/dtlmenu/lunch/", genre: ["洋食"], fee:1000 , comment: '大人のお子様らんち'},
        { name: "クリスクロス", url: "https://tabelog.com/tokyo/A1306/A130602/13148003/", genre: ["洋食","カフェ"], fee:1200 , comment: 'テラス席があってお天気の良い日におすすめ　サラダやハンバーガーなどいろいろあるよ'},
        { name: "GRANNY SMITH APPLE PIE & COFFEE", url: "https://tabelog.com/tokyo/A1306/A130602/13160850/", genre: ["カフェ"], fee: 500, comment: 'たまには息抜きしてね　アップルパイおいしいよ'},
        { name: "モンスーンカフェ", url: "https://tabelog.com/tokyo/A1306/A130602/13169335/", genre: ["カフェ","アジアン"], fee:1000 , comment: 'タイ・ベトナム料理がお洒落な雰囲気で楽しめるよ'},
        { name: "コメダ珈琲", url: "https://tabelog.com/tokyo/A1303/A130301/13197967/", genre: ["カフェ","イタリアン"], fee:700 , comment: '近いのに、あんまりみんな行ってない'},
        { name: "ねぎし", url: "https://tabelog.com/tokyo/A1306/A130602/13130642/", genre: ["和食"], fee:1200 , comment: '牛タン〜　お肉〜'},
        { name: "サイゼリア", url: "https://tabelog.com/tokyo/A1303/A130301/13121502/", genre: ["イタリアン"], fee:500 , comment: 'いつものランチ代でたくさん注文できるよ！お腹一杯になるね'},
        { name: "蓬莱・HOURAI", url: "https://tabelog.com/tokyo/A1306/A130602/13001138/", genre: ["中華"], fee:950 , comment: '中華ならなんでもあるけど　店員さんのくせがすごい'},
        { name: "revive kitchen", url: "https://tabelog.com/tokyo/A1306/A130601/13161158/", genre: ["カフェ"], fee:1100 , comment: 'いわゆるおしゃれなお店　グルテンフリーのパスタがなんたらかんたら'},
        { name: "サンマルクカフェ", url: "https://tabelog.com/tokyo/A1306/A130602/13152492/", genre: ["カフェ"], fee:500 , comment: 'チョコクロおいしい'},
        { name: "パン・オ・スリール", url: "https://tabelog.com/tokyo/A1306/A130602/13147336/", genre: ["カフェ"], fee:1000 , comment: '美味しいパンで作るサンドイッチ・フレンチトースト　軽食でいいかなって時に'},
        { name: "寿司酒場 おもてなし", url: "https://tabelog.com/tokyo/A1303/A130301/13199419/", genre: ["和食"], fee:1000 , comment: '実は近くでお寿司が食べれる　丼もあるよ'},
        { name: "TINTO COFFIEE", url: "https://tabelog.com/tokyo/A1303/A130301/13192788/", genre: ["カフェ"], fee:400 , comment: '目さまして'},
        { name: "おなかなんて空いてない", url: "http://tiqav.com/3yJ.png", genre: ["ダイエット"], fee:0 , comment: '悟り…'},
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
          URL: #{recommend[:url]}
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
