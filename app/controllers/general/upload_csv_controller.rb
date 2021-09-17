require 'csv'

module General
  class UploadCsvController < ApplicationController

    def index; end

    def import
      if Congressperson.import_congresspeople(params[:file])
        redirect_to general_congresspeople_path, notice: 'Dados carregados com sucesso!'
      else
        redirect_to general_upload_csv_index_path, notice: 'O formato do arquivo, não é csv!'
      end
    end

  end
end
