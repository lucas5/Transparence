class CreateSpendings < ActiveRecord::Migration[6.0]
  def change
    create_table :spendings do |t|
      t.references :congressperson, foreign_key: { to_table: :congresspeople }

      t.date :emission_date
      t.text :txt_provider
      t.decimal :net_value
      t.string :url_document
      t.integer :num_year

      t.timestamps
    end
  end
end
