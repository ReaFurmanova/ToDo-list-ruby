# # Pre-configurations (Change if you want an awesome difficulty assessment)

require_relative './config/application'
# # Your Code begins from this line onwards #

 # when I want schema in terminal - go to file where is database, "sqlite3 name of file.db" - SQLite write ".schema", end - control +z

class ToDo < ActiveRecord::Base

	validates :description, presence: true, uniqueness: true
	# dopln hlasku zaznam jiz je v databazi

# # Remove
	def self.remove(id)
		tasks = ToDo.all
		task = tasks[id.to_i - 1]
		task.destroy
	end

# All
	def self.list
		toDos = ToDo.all
		order_index = 1
		lineWidth = 60
		puts
		puts ("  Your To Do list  ").center(lineWidth)
		puts ("===================").center(lineWidth)
		puts
		puts (" No.").ljust(10) + (" Descrition").ljust(43) + ("Status")
		puts ("=====").ljust(10) + ("============").ljust(43) + ("=======")
		toDos.each do |task|
			if task.status == "done"
				puts ("   #{order_index}").ljust(10) + ("#{task.description}").ljust(43) + ("  o,o  ")
				puts ("\\_/").rjust(58)
				puts ("-")*60
				
			else
				puts ("   #{order_index}").ljust(10) + ("#{task.description}").ljust(43) + ("  o,o  ")
				puts (" ~ ").rjust(58)
				puts ("-")*60
			end
			order_index += 1
		end
		if order_index == 2
			p "In your ToDo list is 1 task"
			puts
		else
			p "In your ToDo list are #{ToDo.all.count} tasks"
			puts
		end	
	end
 
	def self.amend(id)
		lineWidth = 60
		order_index = 1
		tasks = ToDo.all
		puts
		puts ("Your current To Do list!").center(lineWidth)
		puts ("-")*60
		puts (" No.").ljust(10) + (" Descrition").ljust(43) + ("Status")
		tasks.each do |task|
			puts ("  #{order_index}").ljust(10) + ("#{task.description}").ljust(43) + ("#{task.status}")
			order_index += 1
		end
		puts
		puts "What would you like to update: description or status?"
		max = 0
		while max < 4
			what = gets.chomp.downcase
			if what == "description"
				puts "Number of record?"
				id = gets.chomp
				task = tasks[id.to_i - 1]
				puts "Text of your new description"
				newText = gets.chomp
				task.update(description: newText)
				max = 4
			elsif what == "status"
				puts "Number of record?"
				id = gets.chomp
				task = tasks[id.to_i - 1]
				task.update(status: "done")
				max = 4
			else	
				if max == 3
					puts
					puts "!Anything was changed!"
					puts "......................"
					return
				elsif max < 3
					puts "Choose: 'description' or 'status'."
				else
				end
				max += 1
			end
		end
		puts
		puts ("Your To Do list has been changed!").center(lineWidth)
		puts ("-")*60
		puts (" NO.").ljust(10) + (" DESCRIPTION").ljust(43) + ("STATUS")
		order_index = 1
		tasks.each do |task|
			puts ("  #{order_index}").ljust(10) + ("#{task.description}").ljust(43) + ("#{task.status}")
			order_index += 1
		end
	end


ARGV

case ARGV[0]
	when '--add'
		myList = ToDo.create(description: ARGV[1])
		# myList.list

	when '--remove'

		ToDo.remove(ARGV[1])
		

	when '--amend'
		# ARGV.clear - I can use gets.chomp (without error)
		ARGV.clear
		ToDo.amend(ARGV[1])

	when '--list'
		ToDo.list
	end
end








