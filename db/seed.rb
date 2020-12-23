class Seed

    def self.seed_table
        10.times do
            Tweet.new({username: "Matteo", message: Faker::TvShows::MichaelScott.quote}).save
        end

        5.times do
            Tweet.new({username: "Yoda", message: Faker::Quote.yoda}).save
        end

        5.times do
            Tweet.new({username: "Matz", message: Faker::Quote.matz}).save
        end

    end

end