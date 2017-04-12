require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Aulas.sqlite3" 

class Person < ActiveRecord::Base; 
    has_one  :job, :dependent => :destroy
    has_many :shoes, :dependent => :destroy
    has_and_belongs_to_many :hobbies, :dependent => :destroy
end

class Job < ActiveRecord::Base;
    belongs_to :person
end

class Shoe < ActiveRecord::Base; 
    belongs_to :person
end

class Hobbie < ActiveRecord::Base; 
    has_and_belongs_to_many :persons, :dependent => :destroy
end

class Hprelation < ActiveRecord::Base;
    self.table_name = "hobbies_persons"
    belongs_to :hobbie
    belongs_to :person
end

def toHash(args) 
    hash = Hash.new
    for args.each do |a|
        hash[a.split('=').first] = a.split('=').second
    end
    return hash
end

def validate(string)
    a = ["persons", "jobs", "shoes"]
    return a.include?(string)

def insert()
    if validate(ARGV.second)
        hash = toHash(ARGV[2..-1])
        i = Object.const_get(ARGV.second.capitalize.chomp('s')).new(hash)
        i.save()
        print "New #{ARGV.second.chomp('s')} added: "
        p i
    elsif ARGV.second = "hobbies_persons"
        hash = toHash(ARGV[2..-1])
        i = Hprelation.new(hash)
        i.save()
        print "New hobbie-person relation added: "
        p i
    else
        print "Invalid table."
    end
end

def list()
    if validate(ARGV.second)
        Object.const_get(ARGV.second.capitalize.chomp('s')).all.each do |l|
            p l
    elsif ARGV.second = "hobbies_persons"
        Hprelations.all.each do |l|
            p l
    else
        print "Invalid table."
    end
end

def exclude()
    if validate(ARGV.second)
        hash = toHash(ARGV[2..-1])
        ex = Object.const_get(ARGV.second.capitalize.chomp('s')).where(hash)
        print "Removing following #{ARGV.second}: "
        ex.each do |e|
            e.destroy()
            p e
    elsif ARGV.second = "hobbies_persons"
        hash = toHash(ARGV[2..-1])
        ex = Hprelation.where(hash)
        print "Removing following hobbie-person relations: "
        ex.each do |e|
            e.destroy()
            p e
    else
         print "Invalid table."  
    end
end

#=begin
case ARGV.first
when 'insert'
    insert()
when 'list'
    list()
when 'exclude'
    exclude()
when 'change'
    change()
else
    puts 'invalid command.'
end
#=end