Lita.configure do |config|
  config.robot.name = "Lita"
  config.robot.log_level = :info
  config.robot.adapter = :slack

  config.adapters.slack.token = ENV["SLACK_API_KEY"]
  config.redis[:url] = ENV["REDISTOGO_URL"]
  config.http.port   = ENV["PORT"]
end
