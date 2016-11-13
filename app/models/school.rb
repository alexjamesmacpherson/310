class School < ApplicationRecord
  has_many :users, dependent: :destroy
end
