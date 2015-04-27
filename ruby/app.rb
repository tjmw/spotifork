require 'sinatra/base'
require 'rss'
require 'open-uri'
require 'dalli'
require 'rack-cache'

class App < Sinatra::Base
  BEST_NEW_TRACKS_RSS   = 'http://pitchfork.com/rss/reviews/best/tracks/'.freeze
  BEST_NEW_ALBUMS_RSS   = 'http://pitchfork.com/rss/reviews/best/albums/'.freeze
  BEST_NEW_REISSUES_RSS = 'http://pitchfork.com/rss/reviews/best/reissues/'.freeze

  helpers do
    def read_rss(feed_url)
      open(feed_url) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items
      end
    end

    def best_new_tracks
      read_rss(BEST_NEW_TRACKS_RSS)
    end

    def best_new_albums
      read_rss(BEST_NEW_ALBUMS_RSS)
    end

    def best_new_reissues
      read_rss(BEST_NEW_REISSUES_RSS)
    end

    def cache_headers
      cache_control :public, max_age: 3600
    end
  end

  get '/' do
    erb :home
  end

  get '/tracks' do
    cache_headers
    erb :tracks
  end

  get '/albums' do
    cache_headers
    erb :albums
  end

  get '/reissues' do
    cache_headers
    erb :reissues
  end
end
