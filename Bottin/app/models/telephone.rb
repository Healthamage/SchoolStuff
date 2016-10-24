class Telephone < ApplicationRecord
	belongs_to :contact
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
end
