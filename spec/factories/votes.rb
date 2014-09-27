# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    user_id 1
    round 1
    candidate_id 1
    class_name "A"

    factory :invalid_vote do
    	user_id nil
    	round nil
    	candidate_id nil
    	class_name nil
    end

    factory :modify_vote do
        candidate_id 2 
    end
  end
end
