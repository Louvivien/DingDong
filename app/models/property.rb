class Property < ApplicationRecord
	belongs_to :agent
	belongs_to :agency
	belongs_to :area

	has_many_attached :images
	has_many :visits

	has_many :favorites
	has_many :tenants, through: :favorites

	validates :title, 
	:surface, 
	:address, 
	:room, 
	:description, 
	:price, 
	:floor, 
	:available_date, presence: true

	validates :room, numericality: { only_integer: true }
	validates :price, numericality: { only_integer: true }
	validates :surface, numericality: true
	validates :floor, numericality: { only_integer: true }
	validates :description, length: { minimum: 40 }
	validates :title, length: { minimum: 10 }

	def self.not_archived
		self.where(is_archived: false)
	end 

	def total_rent
		self.price.to_i + self.charges.to_i
	end

	def existant_fav(tenant)
		Favorite.find_by(property_id: self.id, tenant: tenant)
	end

	def requested_visits(tenant)
		self.visits.where(visit_status_id: 4, tenant: tenant)
	end

	def requested_visits_agency
		self.visits.where(visit_status_id: 4, property: self)
	end

end
