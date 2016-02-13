class TomBaseCharacter 
	attr_reader :hit_base 
	
	attr_reader :damage_base
	
	attr_reader :dodge_base
	
	attr_reader :st_base

	attr_reader :dc_base

	attr_reader :resistance_base

	attr_reader :movement_base

	attr_reader :hp_base

	attr_reader :condition_immunities_base

	attr_reader :damage_immunities_base


	attr_accessor :hit_actual
	
	attr_accessor :damage_actual
	
	attr_accessor :dodge_actual
	
	attr_accessor :st_actual

	attr_accessor :dc_actual

	attr_accessor :resistance_actual

	attr_accessor :movement_actual
	
	attr_accessor :hp_actual

	attr_accessor :damage_immunities_actual

	attr_accessor :condition_immunities_actual
	
	attr_accessor :conditions

	attr_accessor :is_confused
	
	attr_accessor :is_berserk

	def initialize(hit_base,damage_base,dodge_base,st_base,dc_base,resistance_base,movement_base,hp_base,condition_immunities_base,damage_immunities_base)
		@minor_bonus=2
		@major_bonus=5
		@base_score=3

	end



	def isHit?(roll,defense)
		roll>@dodge_actual[defense]
	end

	def hasSaved?(dc,defense)
		return rollDice(20)+@st_actual[defense]>=dc
	end

	def rollDice(dice)
		rand(dice)+1
	end


	def hitRoll(attack_type,bonus)
		return rollDice(20)+@hit_actual[attack_type]+bonus
	end

	def attackDamage(attack_type,bonus)
		return rollDice(20)+@damage_actual[attack_type]+bonus
	end

	def applyDamage(damage, damage_type, ignores_resistance)
		if not @damage_immunities[damage_type]
			@hp_actual=@hp_actual-(@damage-resistance[damage_type])
		end
	end

	def applyCondition(condition)
		if not @condition_immunities[condition]==true
			@conditions.push(condition)
		end
	end

	def canAct?
		conditions.each do |condition|
			if not condition.allowsTurn return false
		end
		return true
	end


end