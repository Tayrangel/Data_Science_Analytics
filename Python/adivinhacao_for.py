print("*****************")
print("Bem vindo ao jogo de Adivinhação")
print("*****************")

numero_secreto = 42
total_tentativas = 5

for rodada in range(1, total_tentativas + 1):
    print("Tentativa {} de {}".format(rodada, total_tentativas))
    chute_str = input("Digite um número entre 1 e 100:")
    print("Você digitou:", chute_str)
    chute = int(chute_str)

    if(chute < 1 or chute > 100):
        print("Você deve digitar um número entre 1 e 100.")
        continue
    
    acertou = numero_secreto == chute
    numero_maior = chute < numero_secreto
    numero_menor = chute > numero_secreto

    if(acertou):
        print("Você Acertou!")
        break
    else:
        if(numero_maior):
            print("Você Errou!O valor é maior que o número secreto.")
        elif(numero_menor):
            print("Você Errou!O valor é menor que o número secreto.")

print("Fim do Jogo")