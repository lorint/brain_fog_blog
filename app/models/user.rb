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
end
