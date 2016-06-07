# RUBY'S BUILT-IN METHOD FLASHCARDS
# Ideas for the program functionality:
# 	User chooses to add new cards, alter existing cards, or start quiz
# 		Perhaps you can alter mid-quiz?
# 	Add card method
# 	Alter card method
# 	Check if card exists already method (for both adding and altering)
# 	Quiz/random select method

# Table should include: 
# 1) the name/syntax of the method and what classes you can call the method on (keep it basic: strings, integers, floats, arrays, hashes)
# 2) a description of what the method does 
# 3) if the method can take a block or argument 
# 4) what the methods outputs
# 5) if the method permanently alters the original object

require 'sqlite3'

db = SQLite3::Database.new("cards.db")
db.results_as_hash = true

create_table_command = <<-SQL
	CREATE TABLE IF NOT EXISTS ruby_methods(
		id INTEGER PRIMARY KEY,
		name varchar(255),
		function varchar(255),
		takesarg boolean,
		output varchar(255),
		permanent boolean
	)
SQL

db.execute(create_table_command)

####### BEGIN METHOD BLOCK #######

# Method that adds new card info into the database
def add_card (database)
	add_loop = false
	until add_loop
		puts "\nWhat is the syntax and applicable class of the method? Example: .each (Array)"
		syntax = gets.chomp 
		# CHECK FOR DUPLICATE
		# if duplicate_checker(syntax) returns true puts "already a card"
		# else returns false and continues
		puts "\nWhat does the method do?"
		does = gets.chomp
		puts "\nCan this method take and argument or block? If so, explain."
		takes = gets.chomp
		puts "\nWhat is the direct output of this method?"
		outs = gets.chomp
		puts "\nAfter the method has executed, does it permanently alter the original object?"
		perm = gets.chomp
		database.execute("INSERT INTO ruby_methods (name, function, takesarg, output, permanent) VALUES (?, ?, ?, ?, ?)", [syntax, does, takes, outs, perm])
		puts "\nDo you want to add another card?"
		continue = to_boolean(gets.chomp)
			if continue == false
				add_loop = true
			else
			end
	end
end

# Method that quizzes the user
def card_quiz (database)
	cards = database.execute("SELECT * FROM ruby_methods") # cards is an array
	quiz_loop = false
	until quiz_loop
		current_card = cards.sample # takes a nested hash from the cards array
		puts "\n--------------------\n#{current_card["name"]}\n--------------------"
		puts "\nWhat does this method do? Take a guess to flip the card."
		gets.chomp
		puts "\nFunction: #{current_card["function"]}\nTakes argument or block: #{current_card["takesarg"]}\nOutput: #{current_card["output"]}\nAlters original: #{current_card["permanent"]}"
		puts "\nDoes this card need updating?"
		update = to_boolean(gets.chomp)
			if update
		 		update_card(database, current_card["id"])
		 	else
		 	end
		puts "\nOne more card?"
		done = to_boolean(gets.chomp)
			if done == false
				quiz_loop = true
			else
			end
	end
end

# Method that updates a card
def update_card (database, i)
	update_loop = false
	until update_loop
		puts "\nWould you like to update:\n1) The syntax and class\n2) The function of the method\n3) If the argument takes a block/argument or not\n4) The output of the method\n5) Whether or not it alters the original object\n6) No changes needed"
		input = gets.chomp.to_i
		case input
		when 1
			puts "What should the new answer be?"
			update_syntax = gets.chomp
			database.execute("UPDATE ruby_methods SET name = ? WHERE id = ?", [update_syntax, i])
		when 2
			puts "What should the new answer be?"
			update_function = gets.chomp
			database.execute("UPDATE ruby_methods SET function = ? WHERE id = ?", [update_function, i])
		when 3
			puts "What should the new answer be?"
			update_arg = gets.chomp
			database.execute("UPDATE ruby_methods SET takesarg = ? WHERE id = ?", [update_arg, i])
		when 4
			puts "What should the new answer be?"
			update_output = gets.chomp
			database.execute("UPDATE ruby_methods SET output = ? WHERE id = ?", [update_output, i])
		when 5
			puts "What should the new answer be?"
			update_perm = gets.chomp
			database.execute("UPDATE ruby_methods SET permanent = ? WHERE id = ?", [update_perm, i])
		when 6
			update_loop = true
		else
			puts "I'm sorry, I didn't understand"
		end
	end
end

# Method that checks if the card is duplicate
def duplicate_checker (database, key)

end

# Method that converts input to boolean value
def to_boolean(input)
	case input[0].downcase
	when "y"
		return true
	when "n"
		return false
	else
		return false
	end
end


####### BEGIN UI #######

puts "\nWelcome to the Ruby Method Flashcard Quizzer Thinger!\n"
choice_loop = false
until choice_loop
	puts "\nWould you like to\n1) Add new flashcards\n2) Quiz yourself\n3) Exit the program"
	choice = gets.chomp.to_i
	case choice 
	when 1
		add_card(db)
	when 2 
		card_quiz(db)
	when 3
		puts "\nThank you for using the Ruby Method Flashcard Quizzer Thinger!"
		choice_loop = true
	else
		puts "\nI'm sorry, I didn't understand."
	end
end

