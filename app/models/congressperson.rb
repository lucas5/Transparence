class Congressperson < ApplicationRecord
  has_many :spendings, class_name: 'Spending'

  # Returns an array of objects with the deputies and the sum total of all their expenses
  def self.rank(year = Time.current.year, estado = "SE")
    Spending.joins(:congressperson).where(num_year: year).where("congresspeople.sg_uf = ?", estado)
            .order("sum_net_value DESC").group(:congressperson).sum(:net_value)
  end

  # Returns a list of deputies filtered by year and state
  def self.list_congresspeople(year = Time.current.year, estado = "SE")
    year = year.present? ? year : Time.current.year
    joins(:spendings).where("spendings.num_year = ?", year).where(sg_uf: estado).order(:name).distinct
  end

  # Create a deputy based on imported csv data
  def self.create_congresspeople(congresspeople)
    congresspeople.each do |congressperson|
      sg_uf = congressperson[5].strip.delete('"')
      next unless sg_uf == "SE"

      cp = Congressperson.find_or_create_by(name: congressperson[0].strip.delete('"'),
                                            cpf: congressperson[1].strip.delete('"'),
                                            ide_registration: congressperson[2].strip.delete('"'),
                                            nu_parliamentary_card: congressperson[3].strip.delete('"'),
                                            political_party: congressperson[6].strip.delete('"'),
                                            sg_uf: congressperson[5].strip.delete('"'))

      Spending.find_or_create_by(congressperson_id: cp.id,
                                 emission_date: congressperson[16].strip.delete('"').to_time,
                                 txt_provider: congressperson[12].strip.delete('"'),
                                 net_value: congressperson[19].strip.delete('"'),
                                 url_document: congressperson[30].strip.delete('"'),
                                 num_year: congressperson[21].strip.delete('"'))
    end
  end

  # Receive information from a file checks if its format is csv if yes reads it
  def self.import_congresspeople(csv_file)
    accepted_formats = [".csv"]
    begin
      congresspeople = CSV.read(csv_file.path, quote_char: "\x00", col_sep: ";").drop(1)
      is_valid = accepted_formats.include? File.extname(csv_file.original_filename)
      if is_valid
        create_congresspeople(congresspeople)
        true
      else
        false
      end
    rescue StandardError
      false
    end
  end

end
