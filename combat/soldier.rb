class Soldier < TomClass 
	def initialize
		@hit_base["m"]=@base_score
		@hit_base["r"]=@base_score
		@dodge_base["p"=@base_score
		@dodge_base["m"]=@base_score
		@damage_base["p"]=@base_score+@minor_bonus
		@damage_base["m"]=@base_score-@minor_bonus
		@hp_base=12
		@st_base["p"]=@base_score+@minor_bonus
		@st_base["m"]=@base_score-@minor_bonus
		@dc_base["p"]=@base_score
		@dc_base["m"]=@base_score
		
		@resistance_base["p"]=@base_score+@minor_bonus
		@resistance_base["f"]=@base_score-@minor_bonus
		@resistance_base["w"]=@base_score-@minor_bonus
		@resistance_base["a"]=@base_score-@minor_bonus
		@resistance_base["e"]=@base_score-@minor_bonus
		
		@movement_base=5

		@condition_immunities_base=Array.new
		@damage_immunities_base=Array.new

		@hit_actual=@hit_base
		@damage_actual=@damage_base
		@dodge_actual=@dodge_base
		@st_actual=@st_base
		@dc_actual=@dc_base
		@resistance_actual=@resistance_base
		@movement_actual=@movement_base
		@hp_actual=@hp_base
		@condition_immunities_actual=@condition_immunities_base
		@damage_immunities_actual=@damage_immunities_base
		@conditions_actual=Array.new
	end
	
end