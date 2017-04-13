require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Project.sqlite3" 
                    


ActiveRecord::Base.connection.create_table :jobs do |t|  
  t.belongs_to :civilian, foreign_key: true
  t.string :job_name
end

ActiveRecord::Base.connection.create_table :shoes do |t|  
  t.references :civilian,  foreign_key: true
  t.integer :size
  t.string  :brand 
end

ActiveRecord::Base.connection.create_table :interests do |t|  
  t.string  :name 
end

ActiveRecord::Base.connection.create_table :civilians do |t|  
  t.string   :first_name 
  t.string   :last_name 
  t.string   :address 
  t.string   :city 
end

ActiveRecord::Base.connection.create_table :civilians_interests do |t|  
  t.references :civilian
  t.references :interest
end