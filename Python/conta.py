#Classe
class Conta:
    #Construtor
    def __init__(self, numero, titular, saldo, limite):
        print("Construido objeto ... {}".format(self))
        #Atributos privados (__) do objeto(self)
        self.__numero = numero
        self.__titular = titular
        self.__saldo = saldo
        self.__limite = limite
    
    #Métodos do objeto (self)
    def extrato(self):
        print ("Saldo de {} do titular {}".formato(self.saldo, self.titular))

    def deposita(self, valor):
        self.__saldo += valor

    #Método privado
    def __pode_saque(self, valor_sacar):
        valor_disponivel = self.__saldo + self.__limite
        return valor_sacar <= valor_disponivel

    def saque(self, valor):
        if(self.__pode_saque(valor)):
            self.__saldo -= valor
        else:
            print("O valor {} passou o limite.".format(valor))

    def transfere(self, valor, destino):
        self.saque(valor)
        destino.deposita(valor)

    def get_saldo(self):
        return self.__saldo
    
    def get_titular(self):
        return self.__titular
    
    #Método Get
    @property
    def limite(self):
        return self.__limite
    
    #Método Set
    @limite.setter
    def limite(self, limite):
        self.__limite = limite

    #Método estático, método da classe - sua utilização alta, prejudica o POO
    @staticmethod
    def codigo_banco():
        return {'BB':'001', 'Caixa':'104', 'Bradesco':'237'}