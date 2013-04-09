namespace :db do
	task :add_col_sum => :environment do
		User.where(:sum => nil).each do |user|
			user.update_attribute(:sum, user.karma_points.sum("value"))
		end

	end
end