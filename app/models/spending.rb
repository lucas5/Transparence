class Spending < ApplicationRecord
  belongs_to :congressperson, class_name: 'Congressperson'
end
