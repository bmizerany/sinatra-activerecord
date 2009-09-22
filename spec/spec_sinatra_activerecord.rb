root = File.expand_path(File.dirname(__FILE__) + '/..') 
$: << "#{root}/lib"

require 'sinatra/base'
require 'sinatra/activerecord'

class MockSinatraApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end

describe 'A Sinatra app with ActiveRecord extensions' do
  before {
    File.unlink 'test.db' rescue nil
    ENV.delete('DATABASE_URL')
    @app = Class.new(MockSinatraApp)
    #@app.set :migrations_log, File.open('/dev/null', 'wb')
  }

  it 'exposes the Sequel database object' do
    @app.should.respond_to :database
  end

  it 'uses the DATABASE_URL environment variable if set' do
    ENV['DATABASE_URL'] = 'sqlite://test-database-url.db'
    @app.database_url.should.equal 'sqlite://test-database-url.db'
  end

  it 'uses sqlite://<environment>.db when no DATABASE_URL is defined' do
    @app.environment = :foo
    @app.database_url.should.equal "sqlite://foo.db"
  end

  it 'establishes a database connection when set' do
    @app.database = 'sqlite://test.db'
    @app.database.should.respond_to :table_exists?
  end

end
