#O arquivo modelo é para caracterizar o local que criamos os conceitos de classes

#Criando uma Herança
class Programa:
    def __init__(self, nome, ano):
        self._nome = nome.title() 
        self.ano = ano
        self._likes = 0 

    @property
    def likes(self):
        return self._likes
    
    def dar_like(self):
        self._likes += 1

    @property
    def nome(self):
        return self._nome
    
    @nome.setter
    def nome(self, novo_nome):
        self._nome = novo_nome.title()

#Criando um classe filho com informação da Herança Mãe (Programa)
class Filme(Programa):
    #pass permite que eu passe para outra etapa do código
    #definindo o inicializador(construtor) e atributos
    def __init__(self, nome, ano, duracao):
        self._nome = nome.title()
        self.ano = ano
        self.duracao = duracao
        self._likes = 0 

class Serie(Programa):
    def __init__(self, nome, ano, temporadas):
        self._nome = nome.title()
        self.ano = ano
        self.temporadas = temporadas
        self._likes = 0

#Criando um objeto
vingadores = Filme("vingadores - guerra infinita", 2018, 160)
vingadores.dar_like()
print(f"Nome: {vingadores.nome} - Ano: {vingadores.ano} - Duração: {vingadores.duracao} - Likes: {vingadores.likes}")

atlanta = Serie("atltanta", 2020, 3)
atlanta.dar_like()
atlanta.dar_like()
print(f"Nome: {atlanta.nome} - Ano: {atlanta.ano} - Temporadas: {atlanta.temporadas} - Likes: {vingadores.likes}")


#name mangling _Programa__likes