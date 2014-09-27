# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :class => User do
    name "张三"
    mobile "18616833001"
    class_name "A"

    factory :invalid_user, :class => User do
    	name ""
    	mobile ""
    	class_name ""
    end

    factory :modify_user, :class => User do
    	name '李四'
    	class_name 'B'
    end
  end
end
