require 'sqlite3'
require 'pry'
require 'faker'

require_relative '../lib/tweet'
require_relative '../lib/cli'
require_relative '../db/seed'

DB = {
    conn: SQLite3::Database.new("db/tweets.db")
}
#fire sql statement to the db by typing DB[:conn].execute
DB[:conn].results_as_hash = true