Sinatra ActiveRecord Extension
========================

Extends [Sinatra](http://www.sinatrarb.com/) with a extension methods and Rake
tasks for dealing with a SQL database using the [ActiveRecord ORM](http://api.rubyonrails.org/).

Install the `sinatra-activerecord` gem along with one of the database adapters:

    sudo gem install activerecord
    sudo gem install sinatra-activerecord -s http://gemcutter.org
    sudo gem install sqlite3
    sudo gem install mysql
    sudo gem install postgres

adding this to your `Rakefile`

    # require your app file first
    require 'sinatra-ar-exmple-app'
    require 'sinatra/activerecord/rake'

    $ rake -T
    rake db:create_migration  # create an ActiveRecord migration in ./db/migrate
    rake db:migrate           # migrate your database

create a migration

    $ rake db:create_migration NAME=create_foos
    $ vim db/migrate/20090922043513_create_foos.rb

    class CreateFoos < ActiveRecord::Migration
      def self.up
        create_table :foos do |t|
          t.string :name
        end
      end

      def self.down
      end
    end

run the migration

    $ rake db:migrate

I like to split models out into a separate `database.rb` file and then
require it from the main app file, but you can plop
the following code in about anywhere and it'll work just fine:

    require 'sinatra'
    require 'sinatra/activerecord'

    # Establish the database connection; or, omit this and use the DATABASE_URL
    # environment variable or the default sqlite://<environment>.db as the connection string:
    set :database, 'sqlite://foo.db'

    # At this point, you can access the ActiveRecord::Base class using the
    # "database" object:
    puts "the foos table doesn't exist" if !database.table_exists?('foos')

    # models just work ...
    class Foo < ActiveRecord::Base
    end

    # see:
    Foo.all

    # access the models within the context of an HTTP request
    get '/foos/:id' do
      @foo = Foo.find(params[:id])
      erb :foos
    end

### NOTE about the rip-off

  This Code and README.md is a heavy adaption of [rtomayko's sinatra-sequel](http://github.com/rtomayko/sinatra-sequel/)

Copyright (c) 2009 Blake Mizerany

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
