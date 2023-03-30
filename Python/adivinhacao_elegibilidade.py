print("*****************")
print("Bem vindo ao jogo de Adivinhação")
print("*****************")

numero_secreto = 42

chute_str = input("Digite o seu número:")
print("Você digitou:", chute_str)
chute = int(chute_str)

acertou = numero_secreto == chute
numero_maior = chute < numero_secreto
numero_menor = chute > numero_secreto

if(acertou):
    print("Você Acertou!")
else:
    if(numero_maior):
        print("Você Errou!O valor é maior que o número secreto.")
    elif(numero_menor):
        print("Você Errou!O valor é menor que o número secreto.")

print("Fim do Jogo")