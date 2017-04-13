require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Project.sqlite3" 

class Civilian < ActiveRecord::Base; 
    has_one  :job, :dependent => :destroy
    has_many :shoes, :dependent => :destroy
    has_and_belongs_to_many :interests, :dependent => :destroy
end

class Job < ActiveRecord::Base;
    belongs_to :civilian
end

class Shoe < ActiveRecord::Base; 
    belongs_to :civilian
end

class Interest < ActiveRecord::Base; 
    has_and_belongs_to_many :civilians, :dependent => :destroy
end

class CIRelation < ActiveRecord::Base;
    self.table_name = "civilians_interests"
    belongs_to :interest
    belongs_to :civilian
end

#Transform ARGV given by the user to a hash
def toHash(args) 
    hash = Hash.new
    args.each do |a|
        hash[a.split('=').first] = a.split('=').second
    end
    return hash
end

#Validate if the table passed by the user exists
def validate(string)
    a = ["civilians", "jobs", "shoes", "interests"]
    return a.include?(string)
end

#Insert into the table
def insert()
    if validate(ARGV.second)
        i = Object.const_get(ARGV.second.capitalize.chomp('s')).new(toHash(ARGV[2..-1])) #Transform table name given by the user to the respective class, i.e. civilians => Civilian
        i.save()
        print "New #{ARGV.second.chomp('s')} added: "
        p i
    elsif ARGV.second == "civilians_interests"
        i = CIRelation.new(toHash(ARGV[2..-1]))
        i.save()
        print "New civilian-interest relation added: "
        p i
    else
        print "Invalid table."
    end
end

#List the content of a giving table
def list()
    if validate(ARGV.second)
        Object.const_get(ARGV.second.capitalize.chomp('s')).all.each do |l| #Transform table name given by the user to the respective class, i.e. civilians => Civilian
            p l
        end
    elsif ARGV.second == "civilians_interests"
        CIRelation.all.each do |l|
            p l
        end
    else
        print "Invalid table."
    end
end

#Delete from the table accordinly with a given rule, i.e. last_name="Silva"
def delete()
    if validate(ARGV.second)
        ex = Object.const_get(ARGV.second.capitalize.chomp('s')).where(toHash(ARGV[2..-1])) #Transform table name given by the user to the respective class, i.e. civilians => Civilian
        print "Removing following #{ARGV.second}: "
        ex.inspect
        ex.each do |e|
            e.destroy()
            p e
        end
    elsif ARGV.second == "civilians_interests"
        ex = CIRelation.where(toHash(ARGV[2..-1]))
        print "Removing following civilian-interest relations: "
        ex.each do |e|
            e.destroy()
            p e
        end
    else
         print "Invalid table."  
    end
end

#Update a value in teh table
def update()
    if validate(ARGV.second)
        Object.const_get(ARGV.second.capitalize.chomp('s')).find(ARGV[2].split('=').second).update(toHash(ARGV[3..-1])) #Transform table name given by the user to the respective class, i.e. civilians => Civilian
        c = Object.const_get(ARGV.second.capitalize.chomp('s')).find(ARGV[2].split('=').second)
        print "Após update: "
        p c
    elsif ARGV.second == "civilians_interests"
        CIRelation.find(ARGV[2].split('=').second).update(toHash(ARGV[3..-1]))
        c = CIRelation.find(ARGV[2].split('=').second)
        print "Após update: "
        p c
    else
         print "Invalid table."  
    end
end

#Runs the ruby file to create the table scheme
def createScheme()
    exec 'ruby createScheme.rb'
end

#Run the shellscrip file to seed the tables with a preset content
def seed()
   exec './seeder.sh' 
end

#Run the shellscrip file to list all the content of all the tables
def listall()
    exec './listall.sh'
end

#Run the shellscrip file to drop the table
def dropTable()
    exec 'rm ./Project.sqlite3'
end

#=begin
case ARGV.first
when 'insert', 'insere' then
    insert()
when 'list', 'lista' then
    list()
when 'delete', 'exclui' then
    delete()
when 'update', 'altera' then
    update()
when 'createScheme' then
    createScheme()
when 'seed' then
    seed()
when 'listall' then
    listall()
when 'droptable' then
    dropTable()
else
    puts 'invalid command.'
end
#=end