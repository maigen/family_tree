require 'bundler/setup'
require 'pry'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  system "clear"
  puts 'Welcome to the family tree!'
  puts 'Press enter to view the menu.'
  gets.chomp

  loop do
    puts 'Press a to add a family member. Press l to list out the family members.'
    puts 'Press m to add who someone is married to. Press s to see who someone is married to.'
    puts 'Press p to establish the parents of a person. Press c to see the parents of any child.'
    puts 'Press x to exit.'
    choice = gets.chomp

    case choice
    when 'a'
      add_person
    when 'l'
      list
    when 'c'
      list_parents
    when 'm'
      add_marriage
    when 's'
      show_marriage
    when 'p'
      add_parents
    when 'x'
      exit
    end
  end
end

def add_person
  puts 'What is the name of the family member?'
  name = gets.chomp
  Person.create(:name => name)
  puts name + " was added to the family tree.\n\n"
end

def add_parents
  list
  puts 'What is the name of the child?'
  child = Person.find_by(name: gets.chomp)
  puts 'What is the name of the first parent?'
  parent1 = Person.find_by(name: gets.chomp)
  puts 'What is the name of the second parent?'
  parent2 = Person.find_by(name: gets.chomp)
  child.update(:parent_id_1 => parent1.id, :parent_id_2 => parent2.id)
  puts "#{child.name} now has #{parent1.name} and #{parent2.name} as parents."
end

def list_parents
  list
  puts "Enter the number of the child and I'll show you who their parents are."
  person = Person.find(gets.chomp.to_i)
  parent1 = Person.find(person.parent_id_1)
  parent2 = Person.find(person.parent_id_2)
  puts "#{person.name} is a child of #{parent1.name} and #{parent2.name}\n\n\n"
end

def show_children
  list
  puts "Enter the number of a person and I'll show you who their children are."
  person = Person.find(gets.chomp)
  puts person.name + " is the parent of: " +
end

def add_marriage
  list
  puts 'What is the number of the first spouse?'
  spouse1 = Person.find(gets.chomp)
  puts 'What is the number of the second spouse?'
  spouse2 = Person.find(gets.chomp)
  spouse1.update(:spouse_id => spouse2.id)
  puts spouse1.name + " is now married to " + spouse2.name + "."
end

def list
  system "clear"
  puts 'Here are all your relatives:'
  people = Person.all
  people.each do |person|
    puts person.id.to_s + " " + person.name
  end
  puts "\n"
end

def show_marriage
  list
  puts "Enter the number of the relative and I'll show you who they're married to."
  person = Person.find(gets.chomp)
  spouse = Person.find(person.spouse_id)
  puts person.name + " is married to " + spouse.name + "."
end

menu
