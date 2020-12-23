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
    end

    def display_menu_options
        puts
        puts "What would you like to do?"
        puts "--------------------------"
        puts "[id] Find tweet by id"
        puts "[count] Tweets total count"
        puts "[list] Display all tweets"
        puts "[delete] Delete tweet by id"
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
            when "count"
            when "list"
                display_tweets
                menu
            when "delete"
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
        puts "|#{tweet.id}. #{tweet.username} \n\n #{tweet.message}\n"
        puts "--------------------"
    end

    def display_tweets
        Tweet.all.each do |tweet|
            display_tweet(tweet)
        end
    end

end