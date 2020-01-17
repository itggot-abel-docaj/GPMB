class App < Sinatra::Base

    before do
        @db = SQLite3::Database.new('db/GPMB.db')
        @db.results_as_hash = true
        @notes = @db.execute("SELECT * FROM note")
        @current_user = @db.execute("SELECT * FROM users WHERE id = 1").first
    end

    get '/home' do
        p @notes
        #p @current_user
        slim :'home/index'
    end
end