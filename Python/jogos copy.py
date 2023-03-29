import forca
import adivinhacao_nivel_pont

def escolher_jogo():
    print("*****************")
    print("Escolhe seu jogo!")
    print("*****************")

    print ("(1) Forca (2) Adivinhação")

    jogo = int(input("Qual jogo?"))

    if (jogo == 1):
        print("Jogando forca")
        forca.jogar()
    elif(jogo == 2):
        print("Jogado adivinhação")
        adivinhacao_nivel_pont.jogar()

if(__name__ == "__main__"):
    escolher_jogo()