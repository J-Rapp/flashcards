# FLASHCARD PROGRAM

require 'sqlite3'

db = SQLite3::Database.new("flashcards.db")

create_table_command = <<-SQL
	CREATE TABLE IF NOT EXISTS ruby_methods(
		id INTEGER PRIMARY KEY,
		method_name varchar(255),
		function varchar(255),
		what_classes varchar(255),
		block_or_argument boolean,
		output varchar(255),
		permanent boolean
	)
SQL

db.excecute(create_table_command)