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
		classes varchar(255),
		takesarg boolean,
		output varchar(255),
		permanent boolean
	)
SQL

db.execute(create_table_command)

####### BEGIN METHOD BLOCK #######

# Add card method
def add_card (db, syntax, purpose, class_use, takes_arg, outputs, perm)
	db.execute("INSERT INTO ruby_methods (name, function, classes, takesarg, output, permanent) VALUES (?, ?, ?, ?, ?, ?)", [syntax, purpose, class_use, takes_arg, outputs, perm])
end

# Alter card method
def change_card (db, existing_key, new_value)
	db.execute("UPDATE ruby_methods SET ? WHERE ?" [new_value, existing_key])
end

# Check if duplicate card method
def duplicate_checker (db, key)

end

# Quiz method
def card_quiz

end

####### BEGIN UI #######

puts "\nWelcome to the Ruby Method Flashcard Quizzer!\n"
puts "Would you like to 1) Add new flashcards, 2) Alter existing flashcards, or 3) Quiz yourself?"
choice = gets.chomp.to_i
	if choice == 1
		puts "cool"
	elsif choice == 2
		puts "ok"
	elsif choice == 3
		puts "nice"
	else
		puts "I'm sorry, I didn't understand. Please select 1, 2, or 3."
	end



# explore ORM by retrieving data
# cards = db.execute("SELECT * FROM cards")
# cards.each do |card|
#  puts "#{card['name']} does #{card['function']}"
# end

