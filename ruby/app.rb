require 'sinatra/base'
require 'sinatra/assetpack'
require 'rss'
require 'open-uri'
require 'dalli'
require 'rack-cache'
require 'rspotify'
require 'erb'
require 'sass'
require_relative 'lib/album_presenter'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  assets do
    css :application, [
      '/css/normalize.css',
      '/css/global.css',
      '/css/fonts.css',
      '/css/navigation.css',
      '/css/main.css',
      '/css/album-link-list.css'
    ]

    css_compression :sass
  end

  BEST_NEW_ALBUMS_RSS   = 'http://pitchfork.com/rss/reviews/best/albums/'.freeze
  BEST_NEW_REISSUES_RSS = 'http://pitchfork.com/rss/reviews/best/reissues/'.freeze

  helpers do
    def read_rss(feed_url)
      open(feed_url) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items
      end
    end

    def albums_for(rss_feed)
      read_rss(rss_feed).map {|album|
        RSpotify::Album.search(album.title.gsub(/:/, ''), market: 'GB').first
      }.compact.map {|album|
        AlbumPresenter.new(album)
      }
    end

    def cache_headers
      cache_control :public, max_age: 3600
    end
  end

  get '/' do
    erb :home
  end

  get '/albums' do
    cache_headers
    erb :albums, locals: { best_new_albums: albums_for(BEST_NEW_ALBUMS_RSS) }
  end

  get '/reissues' do
    cache_headers
    erb :reissues, locals: { best_new_reissues: albums_for(BEST_NEW_REISSUES_RSS) }
  end
end
