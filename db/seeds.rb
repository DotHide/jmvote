# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

10.times do |index|
	User.create({ :name => Faker::Name.name, :mobile => "1390000000#{index}", :class_name => 'A' })
end

all_es = %w[鲍倩玲 陈轶菁 陈辉 车晓怡 柴毅明 陈秀芳 陈叶 戴强 董智强 方晓燕 范清 顾静 林洁靓 李晓波 李春燕 李霞 陆慧芳 罗靖 罗健青 浦燕艳 齐磊 邵静波 沈婷 唐子斐 王飞 王华 王晟 翁仕远 乌伟光 吴江 张昊 张旭霞 张斌 张烨 张晖 章风霜 周春霞 周征宇 朱丽敏 朱敏蓉 朱月钮 庄忠云 汪洁云 洪华兴 许细财 陆长虹 闻丽 吴芳 朱慧红 周琴 陈继莺 薛春琴 沈军 滕刚 崔加勇 张正华 顾志俭 朱佩丽]
all_ws = %w[方尧 施建华 翁荣波 林晓晖 李哲 林丽燕 竺豪毅 蔡蓉 黄薏 杜敏 姜晓华 杨芝芳 张悅岚 许红 毛晓轶 钱万峰 周琳 李文昭 张招波 杨旭峰 侯志刚 唐蓉珠 叶全 金烨 梁世声 赵剑 黄颖骏 单鸣 吴娣 朱静芬 孙海明 唐鹏程 龚国秀 曹婷怡 陆鹏云 李新风 忻刚 顾炯 金明 戴李华 汤咏梅 熊瑛 周莉 周强 张节 杨永彬 韩春耀 韩宾林 许迎华 李正茂 顾纪伟 高雪莲 陈芳 郝元 蒋晔 宋光辉 陈茜露 何渊 顾培琼 金誉 李峰]

all_es.each_with_index do |item, index|
  Candidate.create(:no => "E#{index + 1}", :name => item, :class_name => 'E')
end

all_ws.each_with_index do |item, index|
  Candidate.create(:no => "W#{index + 1}", :name => item, :class_name => 'W')
end