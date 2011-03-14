require 'sinatra/base'
require 'sinatra/activerecord'

class MockSinatraApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end

class TestSinatraActiveRecord < Test::Unit::TestCase

  def setup
    File.unlink 'test.db' rescue nil
    ENV.delete('DATABASE_URL')
    @app = Class.new(MockSinatraApp)
  end

  def test_exposes_the_sequel_database_object
    assert @app.respond_to? :database
  end

  def test_uses_the_DATABASE_URL_environment_variable_if_set
    ENV['DATABASE_URL'] = 'sqlite://test-database-url.db'
    assert_equal 'sqlite://test-database-url.db', @app.database_url
  end

  def test_uses_sqlite_url_with_env_if_no_DATABASE_URL_is_defined
    @app.environment = :foo
    assert_equal "sqlite://foo.db", @app.database_url
  end

  def test_establishes_a_database_connection_when_set
    @app.database = 'sqlite://test.db'
    assert @app.database.respond_to? :table_exists?
  end

end
