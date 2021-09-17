module Util
  module EstadosBrasileiros
    ESTADOS = [["Sergipe", "SE"]]

    def self.estado_brasileiro_nome(sigla)
      ESTADOS.each do |estado|
        return estado.first if estado.last == sigla
      end
    end

    def self.estado_brasileiro_sigla(nome)
      ESTADOS.each do |estado|
        return estado.second if estado.first == nome
      end
    end
  end
end
