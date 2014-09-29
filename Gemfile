source 'https://ruby.taobao.org'

# 基础必要的
gem 'rails', '4.1.6'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

# 开发必要的
group :development do
	gem 'spring'
	gem 'better_errors' # 更好地显示错误
	gem 'binding_of_caller' # 配合better_errors更好地调试变量

	# 测试专用组件 RSpec
	gem 'rspec-rails', '~> 2.14.0'
	gem 'factory_girl_rails', '~> 4.2.1'
	gem 'guard-rspec', require: false
	gem 'spork-rails'
	gem 'guard-spork', '~> 1.5.1'
	gem 'childprocess', '~> 0.5.3'
end

# 测试必要的
group :test do, 
	gem 'capybara', '~> 2.1.0'
	gem 'database_cleaner', '~> 1.0.1'
	gem 'launchy', '~> 2.3.0'
	gem 'selenium-webdriver', '~> 2.39.0'
end

# 生产时必要的
group :production do
	gem 'unicorn', '~> 4.8.3'
end

# 部署时必要的
gem 'mina', '~> 0.3.0'

# 常用组件
gem 'faker', '~> 1.1.2'
gem 'simple_form', :git => 'https://github.com/plataformatec/simple_form.git', :branch => 'master' # 表单
gem 'datetimepicker-rails', :git => 'git://github.com/zpaulovics/datetimepicker-rails.git', :branch => 'master', :submodules => true # 日期选择控件
gem 'momentjs-rails', '>= 2.8.1' # 时间处理工具（被datetimepicker依赖）
gem 'paperclip', '~> 4.2' # 上传文件组件
gem 'devise', :git => 'https://github.com/plataformatec/devise.git', :branch => 'master' # 会员管理组件
gem 'bootstrap-sass', '~> 3.2.0' # CSS Style
# gem 'will_paginate', '~> 3.0.7' # 分页组件
gem 'kaminari', '~> 0.16.1' # 分页组件
gem 'rails_admin', :git => 'https://github.com/sferik/rails_admin.git'

# 辅助工具
gem 'rails-i18n', '~> 4.0.0' # 常用 Rails i18n 配置
gem 'devise-i18n', :git => 'https://github.com/tigrish/devise-i18n.git', :branch => 'master' # devise i18n
gem 'airbrake', '~> 4.1.0' # Bug自动通知收集工具
gem 'high_voltage', '~> 2.2.1' # 静态页面助手
gem 'settingslogic', '~> 2.0.9' # 全局配置文件
gem 'bootstrap_helper', '~> 4.2.3' # Bootstrap搭配Rail时的帮助工具类（支持 will_paginate 和 simple_form 模板）