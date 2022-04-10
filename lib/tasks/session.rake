namespace :sessions do
    # taken from: https://maxivak.com/rails-clear-old-sessions-stored-in-database/

    desc "Clear expired sessions more than 1 day old"
    task cleanup: :environment do
        sql = "DELETE FROM sessions WHERE (updated_at < '#{DateTime.now - 1.hour}')"
        ActiveRecord::Base.connection.execute(sql)
    end
end