class Umpire < ActiveRecord::Base
  has_many :games

  attr_accessible :name, :mlb_umpire_id, :games
  # validates_uniqueness_of :umpire_id

  def self.sort_by_performance(umpires)
  	umpire_hash = {}
  	umpires.each do |umpire|
  		correct_percent = Umpire.evaluate_umpire(umpire)
  		umpire_hash[umpire.id] = correct_percent unless correct_percent == nil
  	end
  	umpire_info_array = umpire_hash.sort_by{|k,v| v[3]}.reverse
  	# binding.pry
  	umpire_info_array.map do |umpire|
  		[Umpire.find_by_id(umpire[0]), umpire[1]]
  	end
   	# sorted_umpires = []
  	# umpire_hash.sort_by{|k,v| v}.reverse.each do |umpire|
  	# 	id = umpire[0]
  	# 	sorted_umpires << Umpire.find_by_id(id)
  	# end
  	# binding.pry
  	# sorted_umpires
  end

  def self.evaluate_umpire(umpire)
  	call_array = []
  	umpire.games.each do |game|
  		call_array << Umpire.called_pitches(game) unless game.pitches.empty?
  	end
  	call_array.flatten!
  	begin
  		correct_calls = call_array[0]
  		incorrect_calls = call_array[1]
  		total_calls = call_array[2]
  		decimal_correct = correct_calls/(total_calls.to_f)
  		percent_correct = (decimal_correct * 100).round(2)
  		[correct_calls, incorrect_calls, total_calls, percent_correct]

  	rescue
  		puts "Not a number"
  	end
  end

  def self.called_pitches(game)
  	correct_calls = game.pitches.where(correct_call: true).count
  	incorrect_calls = game.pitches.where(correct_call: false).count
  	total_calls = correct_calls + incorrect_calls
  	[correct_calls, incorrect_calls, total_calls]
  end

end
