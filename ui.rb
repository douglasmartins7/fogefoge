def da_boas_vindas
    puts "Bem vindo ao Foge-foge"
    puts "Qual é o seu nome?"
    nome = gets.strip
    puts "Começaremos o jogo para você, #{nome}"
    nome
end

def pede_movimento 
    puts "Para onde deseja ir"
    movimento = gets.strip
end

def desenha 
    puts mapa
end