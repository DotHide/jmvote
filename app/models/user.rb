class User < ActiveRecord::Base

	presence_fields = %w[name mobile class_name]
	presence_fields.each do |f|
		validates f, :presence => true
	end

	validates :mobile, format: { :with => /\A1\d{10}\z/ }
	validates :class_name, format: { :with => /(A|B){1}/ }
end
