class Umpire < ActiveRecord::Base
  has_many :games

  attr_accessible :name, :mlb_umpire_id, :games
  # validates_uniqueness_of :umpire_id

  def self.sort_by_performance(umpires)
  	umpire_hash = {}
  	umpires.each do |umpire|
  		correct_percent = umpire.evaluate
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

  def evaluate
  	correct_calls = []
    incorrect_calls = []
    total_calls = []
  	self.games.each do |game|
      unless game.pitches.empty?
    		calls = Umpire.called_pitches(game) 
        correct_calls << calls[0]
        incorrect_calls << calls[1]
        total_calls << calls[2]
      end
  	end
    [correct_calls, incorrect_calls, total_calls].map do |call_array|
      call_array.inject(:+)
    end
  end

  def self.called_pitches(game)
  	correct_calls = game.pitches.where(correct_call: true).count
  	incorrect_calls = game.pitches.where(correct_call: false).count
  	total_calls = correct_calls + incorrect_calls
    percent_correct = (correct_calls / total_calls.to_f) * 100
  	[correct_calls, incorrect_calls, total_calls, percent_correct]
  end

  def games
    Game.where(mlb_umpire_id: self.mlb_umpire_id)
  end

  def self.read_umpire_csv
    umpire_hash = {}
    CSV.foreach(File.expand_path('umpire_rank.csv')) do |csv_obj|
      percent_correct = (csv_obj[1].to_i/csv_obj[3].to_f) * 100
      umpire_hash[csv_obj[0]] = [csv_obj[1].to_i, csv_obj[2].to_i, csv_obj[3].to_i, percent_correct]
    end
    umpire_hash
  end

end
