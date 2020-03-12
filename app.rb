class App < Sinatra::Base

    before do
        @db = SQLite3::Database.new('db/GPMB.db')
        @db.results_as_hash = true
        @notes = @db.execute("SELECT * FROM note ORDER BY id DESC")
        @current_user = @db.execute("SELECT * FROM users WHERE id = 1").first
    end

    post '/delete/:id' do
        post_to_delete = params[:id]

        @db.execute('DELETE FROM note
            WHERE id = ?',post_to_delete)
        redirect ('/home')

        #1 DELETE FROM db
        #2 REDIRECT to /home
      end

    get '/' do
    redirect ('/home')
    end

    post '/edit/:id' do
         id_to_edit = params[:id]
        content_to_edit = params[:Editbox]

        @db.execute('UPDATE note SET text = ? WHERE id = ?',content_to_edit, id_to_edit)
        redirect ('/home')

      

        p content
        #update ID o nya params
        #update i sql


          "Hello World"
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