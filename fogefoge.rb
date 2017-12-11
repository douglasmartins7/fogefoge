require_relative 'ui'
require_relative 'heroi'


def le_mapa(numero)
    arquivo = "mapa#{numero}.txt"
    texto = File.read(arquivo)
    mapa = texto.split("\n")
end

def joga(nome)
    mapa = le_mapa(4)
    while true
        desenha mapa
        direcao = pede_movimento

        heroi = encontra_jogador mapa
        nova_posicao = heroi.calcula_nova_posicao direcao
        if !posicao_valida? mapa, nova_posicao.to_array
            next
        end

        mapa[heroi.linha][heroi.coluna] = " "
        mapa[nova_posicao.linha][nova_posicao.coluna] = "H"
        
        mapa = move_fantasmas mapa
        if jogador_perdeu?(mapa)
            game_over
            break
        end

        heroi.remove_do mapa
            if mapa[nova_posicao.linha][nova_posicao.coluna] == "*"
                remove mapa, nova_posicao, 4
            end
            nova_posicao.coloca_no mapa
    end
end

def executa_remocao mapa, posicao, quantidade
    if mapa[posicao.linha][posicao.coluna] == "X"
        return
    end
    posicao.remove_do mapa
    remove mapa, posicao, quantidade - 1
end

def remove mapa, posicao, quantidade
        #não execute isso se for maior do que zero.    
            #return unless quantidade > 0
        if quantidade == 0
            return
        end
        executa_remocao mapa, posicao.direita, quantidade
        executa_remocao mapa, posicao.esquerda, quantidade
        executa_remocao mapa, posicao.cima, quantidade
        executa_remocao mapa, posicao.baixo, quantidade
end

def jogador_perdeu?(mapa)
    perdeu = !encontra_jogador(mapa)
end

def inicia_fogefoge
    nome = da_boas_vindas
    joga nome
end



# def encontra_jogador(mapa)
#     caracter_do_heroi = "H"
#     #for linha in 0..(mapa.size -1)
#     for linha in 0..(mapa.size -1)
#         linha_atual = mapa[linha]
#         coluna_do_heroi = linha_atual.index caracter_do_heroi
#         if coluna_do_heroi
#             #achei
#         end
#     end
#     #não achei
# end

def encontra_jogador(mapa)
    caracter_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_heroi = linha_atual.index caracter_do_heroi
        if coluna_do_heroi
            heroi = Heroi.new
            heroi.linha = linha
            heroi.coluna = coluna_do_heroi
            return heroi
        end
    end
    nil
end

def posicao_valida?(mapa, posicao)
    linhas = mapa.size
    colunas = mapa[0].size

    estourou_linha = posicao[0] < 0 || posicao[0] >= linhas
    estourou_coluna = posicao[1] < 0 || posicao[1] >= colunas

    if estourou_linha || estourou_coluna
        return false
    end

    valor_local = mapa[posicao[0]][posicao[1]]
    
    if valor_local == "X" || valor_local == "F"
        return false
    end
    true
end

def move_fantasmas(mapa)
    caracter_do_fantasma = "F"
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
        #Invocarmos a função chars de nossa String para iterarmos com o each_with_index
        #o Ruby tira uma cópia de nossa array de caractere fazendo um novo array
        linha_atual.chars.each_with_index do |caracter_atual, coluna|
            eh_fantasma = caracter_atual == caracter_do_fantasma
            if eh_fantasma
                move_fantasma mapa, novo_mapa, linha, coluna
            end
        end
    end
    #o array novo deve ser utilizado para o próximo turno
    novo_mapa
end

def move_fantasma(mapa, novo_mapa, linha, coluna)
    posicoes = posicoes_validas_a_partir_de mapa, novo_mapa, [linha, coluna]
    #verificar que existe alguma posição para mover, pergunta para o array se ele está vazio
    if posicoes.empty?
        return
    end

    aleatoria = rand posicoes.size
    #Faremos o fantasma seguir posição aleatoria:
    posicao =  posicoes[aleatoria]

    mapa[linha][coluna] = " "
    novo_mapa[posicao[0]][posicao[1]] = "F"
end


def posicoes_validas_a_partir_de(mapa, novo_mapa, posicao)
    posicoes = []
    movimentos = [[-2, -1], [-2, +1], [+2, -1], [+2, +1],
                  [-1, -2], [-1, +2], [+1, -2], [+1, +2]]
    movimentos.each do |movimento|
        nova_posicao = soma posicao, movimento
        if posicao_valida?(mapa, nova_posicao) && posicao_valida?(novo_mapa, nova_posicao)
            posicoes << nova_posicao
        end
    end
    posicoes
end

def soma(vetor1, vetor2)
    [vetor1[0] + vetor2[0], vetor1[1] + vetor2[1]]
end

def copia_mapa(mapa)
    novo_mapa = mapa.join("\n").tr("F", " ").split("\n")
end





