require 'spec_helper'

describe '投票记录' do
	it "用户ID应该包含" do
		vote = build(:vote, :user_id => nil)
		expect(vote).to_not be_valid
	end
	it "轮数应该包含" do
		vote = build(:vote, :round => nil)
		expect(vote).to_not be_valid
	end
	it "候选人ID应该包含" do
		vote = build(:vote, :candidate_id => nil)
		expect(vote).to_not be_valid
	end
	it "班级应该包含" do
		vote = build(:vote, :class_name => nil)
		expect(vote).to_not be_valid
	end
end
