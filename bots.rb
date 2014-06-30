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

  MAX_ATTEMPTS = 3
  num_attempts = 0
  follower_ids = client.follower_ids

  client.search("what?", :result_type => "recent").take().each do |tweet|
    begin
      # counter and stuff for rate limit protection
      num_attempts += 1
      follower_ids.to_a
      # SCREAM AT THEM
      # *** the following must be updated to tweet.upcase the text /
      # *** from the tweet the "what?" replied to
      # *** any help with this is *extremely* appreciated
      client.update(tweet.upcase, :in_reply_to_status)
      client.search.clear
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
end
