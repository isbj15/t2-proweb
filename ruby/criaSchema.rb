# -*- coding: utf-8 -*-
# Cria uma nova base de dados a cada vez. 
# Para criar o bd execute "ruby criaSchema.rb".

require 'rubygems'
require 'active_record'

# As duas linhas abaixo indicam o SGBD a ser usado (sqlite3) e o nome
# do arquivo que contém o banco de dados (Aulas.sqlite3)
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Aulas.sqlite3" 
                    


ActiveRecord::Base.connection.create_table :profissaos do |t|  
  t.integer :pessoa_id 
  t.string :titulo
end

ActiveRecord::Base.connection.create_table :sapatos do |t|  
  t.integer :pessoa_id  
  t.integer :numero
  t.string  :nome 
end

ActiveRecord::Base.connection.create_table :casas do |t|  
  t.integer :numero
  t.string  :cor 
end

ActiveRecord::Base.connection.create_table :pessoas do |t|  
  #t.integer  :profissao_id - já temos a key user_id na tabela profissaos, não vai precisar de profissao_id em pessoas
  t.string   :last_name 
  t.string   :first_name 
  t.string   :address 
  t.string   :city 
end

ActiveRecord::Base.connection.create_table :casas_pessoas do |t|  
  t.integer :pessoa_id
  t.integer :casa_id
end

