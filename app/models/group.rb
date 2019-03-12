class Group < ApplicationRecord
  has_many :agency_groups
  has_many :agencies, through: :agency_groups
end
