def le_mapa(numero)
    texto = File.read("mapa#{numero}.txt")
    mapa = texto.split("\n")
end
