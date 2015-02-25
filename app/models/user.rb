require 'bcrypt'
class User < ActiveRecord::Base
	has_secure_password

	has_many :posts

	has_attached_file :image, :styles => { 
		:medium => "300x300>", 
		:thumb => "100x100>"
	},
	:default_url => "/images/:style/missing.png"

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates_format_of :email, with: /\A[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/
	
	# TWO alternatives to validate presence of both handle and email:

    # validates :email, presence: true
    # validates :handle, presence: true

#   validates_presence_of :email, :handle

	# Now we want to have either handle or email, or both
	# But it's can't have both email and handle blank

	validate :either_handle_or_email

	def either_handle_or_email
		if (self.handle && self.handle.length > 0) ||
			(self.email && self.email.length > 0)
			return
		else
			self.errors.add(:email, "Must specify either handle or email")
			self.errors.add(:handle, "Must specify either handle or email")
		end
	end

end
