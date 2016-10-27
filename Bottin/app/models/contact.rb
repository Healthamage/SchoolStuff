class Contact < ApplicationRecord
	validate :birthday_must_be_in_the_past
	validates_length_of :first_name, within: 2..20
	validates_length_of :last_name, within: 2..20
	has_many :telephones, dependent: :destroy
	has_many :contacts_works
	def fullname
		self.first_name + " " + self.last_name
	end

	def first_name
		self[:first_name] || ""
	end

	def last_name
		self[:last_name] || ""
	end

	def birthday_must_be_in_the_past
		if self.birthday.present? && self.birthday > Date.today
			errors.add(:birthday,"must be in the past")
		end
	end
end
