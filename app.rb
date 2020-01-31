class App < Sinatra::Base

    before do
        @db = SQLite3::Database.new('db/GPMB.db')
        @db.results_as_hash = true
        @notes = @db.execute("SELECT * FROM note")
        @current_user = @db.execute("SELECT * FROM users WHERE id = 1").first
    end

    get '/home' do
        puts "                                     "
        p @notes
        puts "                              "
        #p @current_user
        slim :'home/index'
    end

    post '/save_note' do

        note = params['note']

         @db.execute('INSERT INTO note
                        (text, timestamp, userid)
                        VALUES (?,?,?)',note, 0, 1)
        redirect '/home'
     end
end