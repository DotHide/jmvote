require 'spec_helper'

describe '用户参与页面', :type => :view do
  it "访问enroll页面内容中应该有'请输入您的手机和姓名'字样" do
    visit '/user/enroll'
    expect(page).to have_content('请输入您的手机和姓名')
  end
end
