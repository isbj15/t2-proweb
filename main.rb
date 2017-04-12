require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Project.sqlite3" 

class Civilian < ActiveRecord::Base; 
    has_one  :job, :dependent => :destroy
    has_many :shoes, :dependent => :destroy
    has_and_belongs_to_many :hobbies, :dependent => :destroy
end

class Job < ActiveRecord::Base;
    belongs_to :civilian
end

class Shoe < ActiveRecord::Base; 
    belongs_to :civilian
end

class Hobbie < ActiveRecord::Base; 
    has_and_belongs_to_many :civilians, :dependent => :destroy
end

class Hhrelation < ActiveRecord::Base;
    self.table_name = "hobbies_civilians"
    belongs_to :hobbie
    belongs_to :civilian
end

def toHash(args) 
    hash = Hash.new
    args.each do |a|
        hash[a.split('=').first] = a.split('=').second
    end
    return hash
end

def validate(string)
    a = ["civilians", "jobs", "shoes", "hobbies"]
    return a.include?(string)
end

def insert()
    if validate(ARGV.second)
        hash = toHash(ARGV[2..-1])
        i = Object.const_get(ARGV.second.capitalize.chomp('s')).new(hash)
        i.save()
        print "New #{ARGV.second.chomp('s')} added: "
        p i
    elsif ARGV.second == "hobbies_civilians"
        hash = toHash(ARGV[2..-1])
        i = Hhrelation.new(hash)
        i.save()
        print "New hobbie-civilian relation added: "
        p i
    else
        print "Invalid table."
    end
end

def list()
    if validate(ARGV.second)
        Object.const_get(ARGV.second.capitalize.chomp('s')).all.each do |l|
            p l
        end
    elsif ARGV.second == "hobbies_civilians"
        Hhrelation.all.each do |l|
            p l
        end
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
        end
    elsif ARGV.second == "hobbies_civilians"
        hash = toHash(ARGV[2..-1])
        ex = Hhrelation.where(hash)
        print "Removing following hobbies-civilian relations: "
        ex.each do |e|
            e.destroy()
            p e
        end
    else
         print "Invalid table."  
    end
end

def change()
    if validate(ARGV.second)
        Object.const_get(ARGV.second.capitalize.chomp('s')).find(ARGV[2].split('=').second).update(toHash(ARGV[3..-1]))
        #pega o registro no banco para printar
        c = Object.const_get(ARGV.second.capitalize.chomp('s')).find(ARGV[2].split('=').second)
        print "Após update: "
        p c
    elsif ARGV.second == "hobbies_civilians"
    else
         print "Invalid table."  
    end
end

#=begin
case ARGV.first
when 'insert'
    ARGV.second.inspect
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