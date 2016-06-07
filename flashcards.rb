# RUBY'S BUILT-IN METHOD FLASHCARDS
# Ideas for the program functionality:
# 	User chooses to add new cards, alter existing cards, or start quiz
# 		Perhaps you can alter mid-quiz?
# 	Add card method
# 	Alter card method
# 	Check if card exists already method (for both adding and altering)
# 	Quiz/random select method

# Table should include: 
# 1) the name/syntax of the method 
# 2) a description of what the method does 
# 3) what classes you can call the method on (keep it basic: strings, integers, floats, arrays, hashes)
# 4) if the method can take a block or argument 
# 5) what the methods outputs
# 6) if the method permanently alters the original object

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

# Add card method
def add_card (database, syntax, purpose, takes_arg, outputs, perm)
	database.execute("INSERT INTO ruby_methods (name, function, takesarg, output, permanent) VALUES (?, ?, ?, ?, ?)", [syntax, purpose, takes_arg, outputs, perm])
end

# Alter card method
def change_card (database, existing_key, new_value)
	database.execute("UPDATE ruby_methods SET ? WHERE ?" [new_value, existing_key])
end

# Check if duplicate card method
def duplicate_checker (database, key)

end

# Quiz method
def card_quiz

end

# Convert to boolean method
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

puts "\nWelcome to the Ruby Method Flashcard Quizzer!\n"
choice_loop = false
until choice_loop
	puts "\nWould you like to\n1) Add new flashcards\n2) Alter existing flashcards\n3) Quiz yourself\n4) Exit the program"
	choice = gets.chomp.to_i
	case choice 
	when 1 # Add card program
		new_loop = false
		until new_loop
			puts "What is the syntax and applicable class of the method? Example: .each (String)"
			method_syntax = gets.chomp # CHECK FOR DUPLICATE
			# if duplicate_checker(method_syntax) returns true puts "already a card"
			# else returns false and continues
			puts "What does the method do?"
			method_function = gets.chomp
			puts "Does this method take and argument or block?"
			takes_a_or_b = gets.chomp
			puts "What does this method put out in the end?"
			puts_out = gets.chomp
			puts "Does this method permanently alter the original object?"
			perm_alter = gets.chomp
			add_card(db, method_syntax, method_function, takes_a_or_b, puts_out, perm_alter)
			puts "Do you want to add another card?"
			continue = to_boolean(gets.chomp)
			if continue == false
				new_loop = true
			else
			end
		end
	when 2 # Alter card program
		puts "ok"
	when 3 # Quiz program
		puts "nice"
	when 4 # End program
		puts "\nThank you for using the Ruby Method Flashcard Quizzer!"
		choice_loop = true
	else
		puts "I'm sorry, I didn't understand."
	end
end



# explore ORM by retrieving data
# cards = db.execute("SELECT * FROM cards")
# cards.each do |card|
#  puts "#{card['name']} does #{card['function']}"
# end

