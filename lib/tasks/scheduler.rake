desc "This task is called by the Heroku scheduler add-on"
task :test => :environment do
	# sorted_umpires = Umpire.sort_by_performance(Umpire.all)
	# sorted_umpires.each do |umpire|
	# 	CSV.open("umpire_rank.csv", "a") do |csv|
	# 		csv << [umpire[0].name, umpire[1][0], umpire[1][1], umpire[1][2], umpire[1][3]]
	# 	end
	# end
	puts "hey"
end



  
