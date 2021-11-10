RakutenWebService.configure do |c|
    # (必須) アプリケーションID
    if Rails.env.production?
      c.application_id = process.env.application_id
    else
      c.application_id = Settings.rakuten[:application_id]
    end

    # (任意) 楽天アフィリエイトID
    if Rails.env.production?
      c.application_id = process.env.affiliate_id
    else
      c.affiliate_id = Settings.rakuten[:affiliate_id] # default: nil
    end

    # (任意) リクエストのリトライ回数
    # 一定期間の間のリクエスト数が制限を超えた時、APIはリクエスト過多のエラーを返す。
    # その後、クライアントは少し間を空けた後に同じリクエストを再度送る。
    c.max_retries = 3 # default: 5

    # (任意) デバッグモード
    # trueの時、クライアントはすべてのHTTPリクエストとレスポンスを
    # 標準エラー出力に流す。
    c.debug = true # default: false
  end
