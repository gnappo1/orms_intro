class CLI

    def start
        Tweet.create_table
        welcome
        menu
    end

    def welcome
        puts "Welcome to my Twitter app!"
    end

    def menu
        display_menu_options
        user_input
        goodbye
        exit
    end

    def display_menu_options
        puts
        puts "What would you like to do?"
        puts "--------------------------"
        puts "[id] Find tweet by id"
        puts "[username] Find tweet by username"
        puts "[count] Tweets total count"
        puts "[update] Update Tweet's username"
        puts "[list] Display all tweets"
        puts "[delete id] Delete tweet by id"
        puts "[delete username] Delete tweet by username"
        puts "[new] Create a new tweet"
        puts "[exit] To exit the program"
        puts
    end

    def user_input
        input = gets.strip.downcase
        until input == "exit"
            case input
            when "id"
                puts "Enter an id:"
                id = gets.strip
                tweet = Tweet.find_by_id(id)
                display_tweet(tweet)
                menu
            when "username"
                puts "Enter a username:"
                username = gets.strip.capitalize
                tweets = Tweet.find_by_username(username)
                display_tweets(tweets)
                menu
            when "count"
                count = Tweet.count_all
                display_count(count)
                menu
            when "update"
                puts "Enter the old username you'd like to edit:"
                old_username = gets.strip
                puts "Enter the new username:"
                new_username = gets.strip.capitalize
                tweet = Tweet.update_by_username(old_username, new_username)
                display_tweet(tweet)
                menu
            when "list"
                display_tweets(Tweet.all)
                menu
            when "delete id"
                puts "Please enter the id of the tweet you'd like to delete"
                id = gets.strip
                Tweet.delete_by_id(id)
                display_tweets(Tweet.all) #delete the row from the db but it still created an empty object and displays as empty
                menu
            when "delete username"
                puts "Please enter the username of the tweet you'd like to delete"
                username = gets.strip.capitalize
                Tweet.delete_by_username(username)
                display_tweets(Tweet.all) #delete the rows from the db but it still created empty objects and displays as empty
                menu
            when "new"
                puts "Enter a username:"
                username = gets.strip
                puts "Enter a message:"
                message = gets.strip
                tweet = Tweet.new(username: username, message: message)
                tweet.save
                display_tweet(tweet)
                menu
            else
                puts "That is not one of the menu options, please try again!"
                display_menu_options
                user_input
            end

        end
    end

    def goodbye
        puts "Thanks for visiting our app, see you soon!"
    end

    def display_tweet(tweet)
        puts "\n--------------------\n"
        # binding.pry
        puts "|#{tweet.id}. #{tweet.username} \n\n #{tweet.message}\n"
        puts "--------------------"
    end

    def display_count(count)
        puts
        puts "The total count of rows is: #{count}"
        puts 
    end

    def display_tweets(tweets)
        tweets.each do |tweet|
            display_tweet(tweet)
        end
    end

end