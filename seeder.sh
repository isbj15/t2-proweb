#!/bin/bash

#Populate civilians
ruby main.rb insert civilians first_name="Joao" last_name="Silva" address="Rua A, 54" city="Curitiba"
ruby main.rb insert civilians first_name="Maria" last_name="Silva" address="Rua A, 54" city="Curitiba"
ruby main.rb insert civilians first_name="Pedro" last_name="Marcelo" address="Rua B, 584" city="Rio de Janeiro"
ruby main.rb insert civilians first_name="Marcelo" last_name="Pedro" address="Rua C, 548" city="São Paulo"
ruby main.rb insert civilians first_name="Mistica" last_name="Xavier" address="Rua A, 55" city="China"
ruby main.rb insert civilians first_name="Ivo" last_name="Júnior" address="Rua Marechal Deodoro, 430" city="Curitiba"

#1x1
ruby main.rb insert jobs civilian_id=1 job_name='Baker'
ruby main.rb insert jobs civilian_id=2 job_name='Policeman'
ruby main.rb insert jobs civilian_id=3 job_name='Gardner'
ruby main.rb insert jobs civilian_id=4 job_name='President'
ruby main.rb insert jobs civilian_id=5 job_name='CEO'
ruby main.rb insert jobs civilian_id=6 job_name='Student'

#1xN
ruby main.rb insert shoes civilian_id=1 size=39 brand='Nike'
ruby main.rb insert shoes civilian_id=1 size=39 brand='Adidas'
ruby main.rb insert shoes civilian_id=1 size=39 brand='Puma'
ruby main.rb insert shoes civilian_id=4 size=42 brand='Converse'
ruby main.rb insert shoes civilian_id=4 size=42 brand='Crocs'
ruby main.rb insert shoes civilian_id=6 size=35 brand='Vans'

#NxN
ruby main.rb insert interests name="play"
ruby main.rb insert interests name="sleep"
ruby main.rb insert interests name="eat"
ruby main.rb insert interests name="study"

ruby main.rb insert civilians_interests civilian_id=1 interest_id=1
ruby main.rb insert civilians_interests civilian_id=1 interest_id=3
ruby main.rb insert civilians_interests civilian_id=2 interest_id=1
ruby main.rb insert civilians_interests civilian_id=3 interest_id=2
ruby main.rb insert civilians_interests civilian_id=6 interest_id=3
ruby main.rb insert civilians_interests civilian_id=6 interest_id=2
