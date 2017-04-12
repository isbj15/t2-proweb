#!/bin/bash
#ENTIDADES FORTES
ruby ruby.rb insere pessoas first_name="Joao" last_name="Silva" city="Curitiba"
ruby ruby.rb insere pessoas first_name="Maria" last_name="Silva" city="Curitiba"
ruby ruby.rb insere pessoas first_name="Joao" last_name="Cordeiro" city="Rio de Janeiro"
ruby ruby.rb insere pessoas first_name="Luis" last_name="Almeida" city="Curitiba"

ruby ruby.rb insere casas cor="Azul" numero="521"
ruby ruby.rb insere casas cor="Azul" numero="522"
ruby ruby.rb insere casas cor="Amarela" numero="522"
ruby ruby.rb insere casas cor="Preta" numero="5222"

#ENTIDADES FRACAS
#1x1
ruby ruby.rb insere profissaos titulo="Diretor" pessoa_id="1"
ruby ruby.rb insere profissaos titulo="Presidente" pessoa_id="2"

#1xN
ruby ruby.rb insere sapatos numero="35" nome="Nike" pessoa_id="1"
ruby ruby.rb insere sapatos numero="42" nome="Adidas" pessoa_id="1"
ruby ruby.rb insere sapatos numero="43" nome="Adidas" pessoa_id="2"

#NxN
ruby ruby.rb insere casas_pessoas pessoa_id="1" casa_id="1"
ruby ruby.rb insere casas_pessoas pessoa_id="2" casa_id="1"
ruby ruby.rb insere casas_pessoas pessoa_id="3" casa_id="1"

ruby ruby.rb insere casas_pessoas pessoa_id="1" casa_id="2"
ruby ruby.rb insere casas_pessoas pessoa_id="2" casa_id="2"