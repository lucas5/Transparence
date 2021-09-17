class CreateCongresspeople < ActiveRecord::Migration[6.0]
  def change
    create_table :congresspeople do |t|
      t.string :name, index: true, nil: false
      t.string :cpf, index: true, nil: false, unique: true
      t.string :ide_registration, index: true

      t.string :nu_parliamentary_card
      t.string :political_party
      t.string :sg_uf, limit: 2

      t.timestamps
    end
  end
end
