require 'uri'
require 'time'
require 'sinatra/base'
require 'active_record'
require 'logger'

module Sinatra
  module ActiveRecordHelper
    def database
      options.database
    end
  end

  module ActiveRecordExtension
    def database=(url)
      @database = nil
      set :database_url, url
      database
    end

    def database
      @database ||= (
        url = URI(database_url)
        ActiveRecord::Base.logger = activerecord_logger
        ActiveRecord::Base.establish_connection(database_options)
        ActiveRecord::Base
      )
    end

  protected

    def database_options
      url = URI(database_url)
      if url.scheme == "sqlite"
        {
          :adapter => "sqlite3",
          :database => url.host
        }
      else
        {
          :adapter => url.scheme,
          :host => url.host,
          :port => url.port,
          :database => url.path[1..-1],
          :username => url.user,
          :password => url.password
        }
      end.merge(database_extras)
    end

    def self.registered(app)
      app.set :database_url, lambda { ENV['DATABASE_URL'] || "sqlite://#{environment}.db" }
      app.set :database_extras, Hash.new
      app.set :activerecord_logger, Logger.new(STDOUT)
      app.database # force connection
      app.helpers ActiveRecordHelper
    end
  end

  register ActiveRecordExtension
end
