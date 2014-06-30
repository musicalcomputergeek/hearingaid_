#!/usr/bin/env ruby
require 'rubygems'
require 'yaml'
require 'twitter'
# ya know becuz u need dat stuff

# keep stuff secret
keys = YAML::load(File.open('keys.yml'))

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = keys['consumer_key']
  config.consumer_secret     = keys['consumer_secret']
  config.access_token        = keys['access_token']
  config.access_token_secret = keys['access_token_secret']
end

client.user("hearingaid_")

  bot.on_mention do |tweet, meta|
    # Reply to a mention
    begin
      bot.reply(tweet, meta[:reply_prefix] + "What?")
    rescue
      bot.reply(dm, "What? #{rand)(9999999)}")
    end
  end

  MAX_ATTEMPTS = 3
  num_attempts = 0
  follower_ids = client.follower_ids

  client.search("what?", "what", "wut?", "wut", "wat?", "wat" :result_type => "recent") do |tweet|
    begin
      # counter and stuff for rate limit protection
      num_attempts += 1
      follower_ids.to_a
      if meta[:reply_prefix].to_s.include? '@hearingaid_'
        # do nothing
      else
        client.update(.upcase, :in_reply_to_status)
      end
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= MAX_ATTEMPTS
        # NOTE: Your process could go to sleep for up to 15 minutes but if you
        # retry any sooner, it will almost certainly fail with the same exception.
        sleep error.rate_limit.reset_in
        retry
      else
        raise
    end
  end

  bot.scheduler.every '24h' do
    # Tweet something every 24 hours
    # See https://github.com/jmettraux/rufus-scheduler
    # bot.tweet("hi")
  end
end
