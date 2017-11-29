require_relative 'ui'

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

mapa = le_mapa(1)
desenha mapa