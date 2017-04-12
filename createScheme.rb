require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Aulas.sqlite3" 
                    


ActiveRecord::Base.connection.create_table :jobs do |t|  
  t.integer :person_id 
  t.string :job_name
end

ActiveRecord::Base.connection.create_table :shoes do |t|  
  t.integer :person_id  
  t.integer :size
  t.string  :brand 
end

ActiveRecord::Base.connection.create_table :hobbies do |t|  
  t.string  :name 
end

ActiveRecord::Base.connection.create_table :persons do |t|  
  t.string   :last_name 
  t.string   :first_name 
  t.string   :address 
  t.string   :city 
end

ActiveRecord::Base.connection.create_table :hobbies_persons do |t|  
  t.integer :person_id
  t.integer :hobbie_id
end