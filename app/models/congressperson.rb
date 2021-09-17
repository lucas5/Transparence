class Congressperson < ApplicationRecord
  has_many :spendings, class_name: 'Spending'

  def self.rank
    Spending.joins(:congressperson).group(:congressperson).sum(:net_value)
  end

  def total_spent(year)
    spendings = Spending.where(congressperson_id: id, num_year: year)
    total = 0
    spendings.find_each do |spent|
      total += spent.net_value
    end
    total
  end

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
