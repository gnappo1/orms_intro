class Tweet

    attr_accessor :username, :message
    attr_reader :id #encapsulation

    # def initialize(username:, message:, id: nil)
    #     self.username, self.message = username, message
    #     @id = id
    # end

    def initialize(hash)
        hash.each do |k, v|
            self.send("#{k}=", v) if self.respond_to?("#{k}=")
        end
        @id = hash["id"]
    end

    def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS tweets(
                id INTEGER PRIMARY KEY,
                message TEXT,
                username TEXT
            )
        SQL
        DB[:conn].execute(sql)
    end

    def save
        if saved?

        else
            sql = <<-SQL
                INSERT INTO tweets
                (username, message) VALUES (?, ?)
            SQL
            DB[:conn].execute(sql, self.username, self.message)
        end

    end

    def saved?
        !self.id.nil?
    end

    def self.all
        sql = <<-SQL
            SELECT * FROM tweets;
        SQL
        tweets_array = DB[:conn].execute(sql)
        self.map_from_db(tweets_array)
    end

    def self.map_from_db(data)
        if data.is_a? Array
            data.map {|row| new_from_db(row)}
        elsif data.is_a? Hash 
            new_from_db(row)
        else
            raise ArgumentError.new("Invalid data type")
        end
    end

    def self.new_from_db(row)
        self.new(row.delete_if {|k, v| k.is_a? Integer})
    end

    def self.find_by_id(id)
        sql = <<-SQL
                 SELECT * FROM tweets WHERE id = ?
        SQL
        tweet = DB[:conn].execute(sql, id).first
        new_from_db(tweet)
    end

    def self.find_by_username(username)
        sql = <<-SQL
                 SELECT * FROM tweets WHERE username = ?
        SQL
        tweets = DB[:conn].execute(sql, username)
        map_from_db(tweets)
    end

    def self.update_by_username(old_username, new_username)
        sql = <<-SQL
                 UPDATE tweets SET username = ? WHERE username = ?
        SQL
        DB[:conn].execute(sql, new_username, old_username)
    end

    def self.delete_by_id(id)
        sql = <<-SQL
            DELETE FROM tweets WHERE id = ?
        SQL
        DB[:conn].execute(sql, id) 
    end

    def self.delete_by_username(username)
        sql = <<-SQL
            DELETE FROM tweets WHERE username = ?
        SQL
        DB[:conn].execute(sql, username)
    end

    def self.count_all
        sql = <<-SQL
            SELECT COUNT(*) FROM tweets
        SQL
        DB[:conn].execute(sql).first.values.first
    end

end