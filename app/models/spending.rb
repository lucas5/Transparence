class Spending < ApplicationRecord
  belongs_to :congressperson, class_name: 'Congressperson'
  scope :filter_by_year, ->(year) { where(num_year: year) }
end
