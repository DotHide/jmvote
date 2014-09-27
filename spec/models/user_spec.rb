require 'spec_helper'

describe '用户（候选人）' do
	it "姓名应该必填" do
		user = build(:user, :name => nil)
		expect(user).to_not be_valid
	end
	it "手机号码应该必填" do
		user = build(:user, :mobile => nil)
		expect(user).to_not be_valid
	end
	it "手机号码应该符合格式要求" do
		user = build(:user, :mobile => '1234567890')
		expect(user).to_not be_valid
	end
	it "班级应该必填" do
		user = build(:user, :class_name => nil)
		expect(user).to_not be_valid
	end
	it "班级应该只能选择A或者B" do
		user = build(:user, :class_name => 'E')
		expect(user).to_not be_valid
	end
end
