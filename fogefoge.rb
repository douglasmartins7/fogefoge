require_relative 'ui'


def le_mapa(numero)
    arquivo = "mapa#{numero}.txt"
    texto = File.read(arquivo)
    mapa = texto.split("\n")
end

def joga(nome)
    mapa = le_mapa(1)
    while true
        desenha mapa
        direcao = pede_movimento
    end
end

def inicia_fogefoge
    nome = da_boas_vindas
    joga nome
end

def encontra_jogador(mapa)
    caracter_do_heroi = "H"
    #for linha in 0..(mapa.size -1)
    for linha = 0..(mapa.size -1)
        linha_atual = mapa[linha]
        coluna_do_heroi = linha_atual.index caracter_do_heroi
        if coluna_do_heroi
            #achei
        end
    end
    #não achei
end

def encontra_jogador(mapa)
    caracter_do_heroi = "H"
    mapa.each do |linha_atual|
        #cade a linha
        coluna_do_heroi = linha_atual.index caracter_do_heroi
        if coluna_do_heroi != - 1
        #achei!
        end
    end    
    #não achei
end

