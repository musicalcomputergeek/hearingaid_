#!/usr/bin/env ruby

require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define as many of these as you like; they will run simultaneously

Ebooks::Bot.new("hearingaid_") do |bot|
  # Consumer details come from registering an app at https://dev.twitter.com/
  # OAuth details can be fetched with https://github.com/marcel/twurl
  bot.consumer_key = "TcSWsro3AiTg0F3UtlS34hxMe" # Your app consumer key
  bot.consumer_secret = "xhPCtSSAnKcQUbU6uTpVHHyCu3tfGQM6T5ml2Ji62buwuHw5sY" # Your app consumer secret
  bot.oauth_token = "2593732968-zkeBcsLRT5oI0y5YI9YTGhwOgN8V3OgmwDbLjKC" # Token connecting the app to this account
  bot.oauth_token_secret = "VFrAMNWh0tcjniEgnkKy7uh0w0Za98HKhJbsPdUoon4mK" # Secret connecting the app to this account

  bot.on_message do |dm|
    # Reply to a DM
    begin
      bot.reply(dm, "What?")
    rescue
      bot.reply(dm, "What? #{rand)(9999999)}")
    end
  end

  bot.on_follow do |user|
    # Follow a user back
    # Not following back atm
    # bot.follow(user[:screen_name])
  end

  bot.on_mention do |tweet, meta|
    # Reply to a mention
    begin
      bot.reply(tweet, meta[:reply_prefix] + "What?")
    rescue
      bot.reply(dm, "What? #{rand)(9999999)}")
    end
  end

  bot.on_timeline do |tweet, meta|
    # Reply to a tweet in the bot's timeline
    # No replies since no follows
    # bot.reply(tweet, meta[:reply_prefix] + "nice tweet")
  end

  bot.twitter.client.search("what?", "what", "wut?", "wut", "wat?", "wat" :result_type => "recent") do |tweet|
    begin
      if meta[:reply_prefix].to_s.include? '@hearingaid_'
        # do nothing
      else
        bot.reply(tweet, meta[:reply_prefix] + meta[:in_reply_to_status].upcase)
      end
    rescue
      # do nothing
    end
  end

  bot.scheduler.every '24h' do
    # Tweet something every 24 hours
    # See https://github.com/jmettraux/rufus-scheduler
    # bot.tweet("hi")
  end
end