print("*****************")
print("Bem vindo ao jogo de Adivinhação")
print("*****************")

numero_secreto = 42

chute_str = input("Digite o seu número:")

print("Você digitou:", chute_str)

chute = int(chute_str)

if(numero_secreto == chute):
    print("Você Acertou!")
else:
    if(chute < numero_secreto):
        print("Você Errou!O valor é maior que o número secreto.")
    elif(chute > numero_secreto):
        print("Você Errou!O valor é menor que o número secreto.")

print("Fim do Jogo")