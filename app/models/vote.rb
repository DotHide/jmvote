class Vote < ActiveRecord::Base

	presence_fields = %w[user_id round candidate_id class_name]
	presence_fields.each do |f|
		validates f, presence: true
	end
end
