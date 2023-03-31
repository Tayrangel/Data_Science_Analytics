#O arquivo modelo é para caracterizar o local que criamos os conceitos de classes

#Criando uma Herança
class Programa:
    def __init__(self, nome, ano):
        self._nome = nome.title() #Para ser um name mangling deveria seguir a sintaxe __nome (_Programa__nome)
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

    def __str__(self):
        return f"{self._nome} - {self.ano} - {self._likes} likes"

#Criando um classe filho com informação da Herança Mãe (Programa)
class Filme(Programa):
    #pass permite que eu passe para outra etapa do código
    #definindo o inicializador(construtor) e atributos
    def __init__(self, nome, ano, duracao):
        super().__init__(nome, ano) #herdando atributos da classe mãe
        self.duracao = duracao

    def __str__(self):
        return f"{self._nome} - {self.ano} - {self.duracao}min - {self._likes} likes"

class Serie(Programa):
    def __init__(self, nome, ano, temporadas):
        super().__init__(nome, ano)
        self.temporadas = temporadas

    def __str__(self):
        return f"{self._nome} - {self.ano} - {self.temporadas}temporadas - {self._likes} likes"

class Playlist:
    def __init__(self, nome, programas):
        self.nome = nome
        self._programas = programas

    def __getitem__(self, item): #duck typing - transforma o comportamento da classe - magic method, dunder
        return self._programas[item]


    @property
    def listagem(self):
        return self._programas 

    def __len__(self): #magic method
        return len(self._programas)

#Criando um objeto
vingadores = Filme("vingadores - guerra infinita", 2018, 160)
atlanta = Serie("atltanta", 2020, 3)
tmep = Filme("todo mundo em pânico", 1999, 100)
demolidor = Serie ("demolidor", 2016, 3)

vingadores.dar_like()
atlanta.dar_like()
atlanta.dar_like()
atlanta.dar_like()
tmep.dar_like()
tmep.dar_like()
demolidor.dar_like()
demolidor.dar_like()
demolidor.dar_like()


filmes_e_series = [vingadores, atlanta, demolidor, tmep]
playlist_fim_de_semana = Playlist("fim de semana", filmes_e_series)

for programa in playlist_fim_de_semana:
    print(programa)
