class App < Sinatra::Base

    before do
        @db = SQLite3::Database.new('db/GPMB.db')
        @db.results_as_hash = true
        @current_user = @db.execute("SELECT * FROM users WHERE id = 1").first
    end

    get '/home' do
        slim :'home/index'
    end
end