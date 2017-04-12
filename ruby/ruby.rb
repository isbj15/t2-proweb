require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Aulas.sqlite3" 

class Pessoa < ActiveRecord::Base; 
    has_one  :profissao, :dependent => :destroy
    has_many :sapatos, :dependent => :destroy
    has_many :propiedades
    has_many :casas, through: :propiedades, :dependent => :destroy
end

class Profissao < ActiveRecord::Base;
    belongs_to :pessoa
end

class Sapato < ActiveRecord::Base; 
    belongs_to :pessoa
end

class Casa < ActiveRecord::Base; 
    has_many :propiedades
    has_many :pessoas, through: :propiedades, :dependent => :destroy
end

#casas_pessoas
#o many-to-many foi feito usando has_many_through nos dois models da relação para facilitar a manipulação
class Propiedade < ActiveRecord::Base;
    self.table_name = "casas_pessoas"
    belongs_to :casa
    belongs_to :pessoa
end

#transforma em hash os parâmetros passados. Ex: last_name="Sendom" city="Curitiba" >>> {"last_name"=>"Sendon","city"=>"Curitiba"}
def toHash(args)
    hash = Hash.new
    args.each do |arg|  
        hash[arg.split('=').first] = arg.split('=').second
    end  
    return hash
end

def insereModel()
    case ARGV.second
    when 'pessoas'
        #puts 'pessoas'
        hash = toHash(ARGV[2..-1])
        pessoa = Pessoa.new(hash)
        pessoa.save()
        print "Pessoa adicionada: "
        p pessoa
    when 'casas'
        #puts 'casas'
        hash = toHash(ARGV[2..-1])
        casa = Casa.new(hash)
        casa.save()
        print "Casa adicionada: "
        p casa
    when 'profissaos'
        #puts 'profissaos'
        hash = toHash(ARGV[2..-1])
        profissao = Profissao.new(hash)
        profissao.save()
        print "Profissao adicionada: "
        p profissao
    when 'sapatos'
        #puts 'sapatos'
        hash = toHash(ARGV[2..-1])
        sapato = Sapato.new(hash)
        sapato.save()
        print "Sapato adicionada: "
        p sapato
    when 'casas_pessoas'
        hash = toHash(ARGV[2..-1])
        propiedade = Propiedade.new(hash)
        propiedade.save()
        print "Propiedade adicionada: "
        p propiedade
    else
        puts "tabela inválida"
    end
end

def excluiModel()
    case ARGV.second
    when 'pessoas'
        hash = toHash(ARGV[2..-1])
        pessoas = Pessoa.where(hash)
        puts "Pessoas removidas: "
        pessoas.each do |pessoa|
            pessoa.destroy()
            p pessoa
        end
    when 'casas'
        hash = toHash(ARGV[2..-1])
        casas = Casa.where(hash)
        puts "Casas removidas: "
        casas.each do |casa|
            casa.destroy()
            p casa
        end
    when 'profissaos'
        hash = toHash(ARGV[2..-1])
        profissaos = Profissao.where(hash)
        puts "Profissaos removidas: "
        profissaos.each do |profissao|
            profissao.destroy()
            p profissao
        end
    when 'sapatos'
        hash = toHash(ARGV[2..-1])
        sapatos = Sapato.where(hash)
        puts "Sapatos removidas: "
        sapatos.each do |sapato|
            sapato.destroy()
            p sapato
        end
    else
        puts "tabela inválida"
    end
end

def listaModel()
    case ARGV.second
    when 'pessoas'
        #puts 'pessoas'
        Pessoa.all.each do |pessoa|
            p pessoa
        end
    when 'casas'
        #puts 'pessoas'
        Casa.all.each do |casa|
            p casa
        end
    when 'profissaos'
        #puts 'pessoas'
        Profissao.all.each do |profissao|
            p profissao
        end
    when 'sapatos'
        #puts 'pessoas'
        Sapato.all.each do |sapato|
            p sapato
        end
    when 'casas_pessoas'
        #puts 'casas_pessoas'
        Propiedade.all.each do |propiedade|
            p propiedade
        end
    else
        puts "tabela inválida"
    end
end

def alteraModel()
    if ARGV.second == "casas_pessoas" then
        prop = Propiedade.find(ARGV[2].split('=').second).update(toHash(ARGV[3..-1]))
        print "Após update: "
        p prop
    else
        #pega o nome da tabela, deixa em UpperCamelCase, remove o "s" no final e transforma em Classe do ruby, pega o registro com id = primeiro param e faz update no resto
        ARGV.second.capitalize[0..-2].constantize.find(ARGV[2].split('=').second).update(toHash(ARGV[3..-1]))
        #pega o registro no banco para printar
        model = ARGV.second.capitalize[0..-2].constantize.find(ARGV[2].split('=').second)
        print "Após update: "
        p model
    end
end
#=begin
case ARGV.first
when 'insere'
    insereModel()
when 'lista'
    listaModel()
when 'exclui'
    excluiModel()
when 'altera'
    alteraModel()
else
    puts 'comando inválido'
end
#=end