import random

def jogar():
    print("*****************")
    print("Bem vindo ao jogo de Adivinhação")
    print("*****************")

    #Variáveis
    numero_secreto = random.randrange(1, 101)
    total_tentativas = 0
    pontos = 1000

    print("Qual nível de dificuldade?")
    print("(1) Fácil (2) Médio (3) Difícil")

    nivel = int(input("Define o nível:"))

    if(nivel == 1):
        total_tentativas = 20
    elif(nivel == 2):
        total_tentativas = 10
    else:
        total_tentativas = 5

    #Lógica for para o looping de rodadas
    for rodada in range(1, total_tentativas + 1):
        print("Tentativa {} de {}".format(rodada, total_tentativas))
        chute_str = input("Digite um número entre 1 e 100:")
        print("Você digitou:", chute_str)
        chute = int(chute_str)

        if(chute < 1 or chute > 100):
            print("Você deve digitar um número entre 1 e 100.")
            continue

    #Acerto ou erro   
        acertou = numero_secreto == chute
        numero_maior = chute < numero_secreto
        numero_menor = chute > numero_secreto

        if(acertou):
            print("Você Acertou e fez {} pontos".format(pontos)) #Pontuação
            break
        else:
            if(numero_maior):
                print("Você Errou!O valor é maior que o número secreto.")
            elif(numero_menor):
                print("Você Errou!O valor é menor que o número secreto.")
            pontos_perdidos = abs(numero_secreto - chute)
            pontos = pontos - pontos_perdidos
    print("Fim do Jogo")

if(__name__ == "__main__"):
    jogar()