class StartOffensiveStance < TomAbility

	def initialize
		super("offensive_stance")
	end
	def apply(character,target)
	   character.ability_effects.add(OffensiveStanceEffect.new)
	   return [nil,nil,nil]
	end
end


class TomAbilityEffectRemover< TomAbility

	def apply(character,target)
		for i in 0..character.ability_effects.size()-1 do
			if (character.ability_effects[i].name=@ability_to_remove)
				character.ability_effects.delete_at(i)
				break
			end
		end
		return [nil,nil,nil]
	end

end

class StopOffensiveStance < TomAbilityEffectRemover
	@ability_to_remove="offensive_stance"

	def initialize
		super("stop_offensive_stance")
	end	
end

class OffensiveStanceEffect < AbilityEffect
	
	def initialize
		super("offensive_stance_effect")
	end
	def shouldApply?(character,target)
		return true
	end
	def apply(character,target)
		character.damage_base["p"]=character.damage_base["p"]+2
	end
	def isOver?(character,target)
		return false
	end	
	def remove(character,target)
		character.damage_base["p"]=character.damage_base["p"]-2
	end
end

class DamageTargetAbility < TomAbility
	def initialize(name,attack_type,damage_type,defense_type,resistence_type,ignores_damage,bonus_hit,bonus_damage)
		super(name)
		@attack_type=attack_type
		@damage_type=damage_type
		@defense_type=defense_type
		@resistence_type=resistence_type
		@ignores_damage=ignores_damage
		@bonus_hit=bonus_hit
		@bonus_damage=bonus_damage

	end

	def apply(character,target)
		target.each do |enemy|
			hit_roll=character.hitRoll(@attack_type,@bonus_hit)
			if target.isHit(hit_roll,@defense_type)
				attack_damage=character.attackDamage(@damage_type,@bonus_damage)
				target.applyDamage(attack_damage,@resistence_type,ignores_damage)
			end
		end
	end
end

class Swing <  DamageTargetAbility 
	def initialize()
		super("swing","p","p","p","p",false,0,0)
	end

end

class TornadoStrike <  DamageTargetAbility
	def initialize
		super("tornado_strike","p","p","p","p",false,0,0)
	end
end

class DestroyResistance <  TomAbility
	def initialize
		super("destroy_resistance")
	end

	def apply(character,target)
		target_effects=Array.new
		hit_roll=character.hitRoll("p",0)
		if target.isHit(hit_roll,"p")
			target_effects.add(DestroyResistenceEffect.new)
		end
		[nil,target_effects,nil]
	end
end

class DestroyResistanceEffect < Effect

	def initialize()
		super("destroy_resistance_effect")
		@turn=0
		@max_turn=3
	end

	def shouldApply?(target)
		result=@turn==0
		@turn=@turn+1
		return result
	end
	def apply(target)
		target.resistance_actual["p"]=target.resistance_actual["p"]-@minor_bonus
	end
	def isOver?(target)
		return @turn==@max_turn
	end	
	def remove(target)
		target.resistance_actual["p"]=target.resistance_actual["p"]+@minor_bonus
	end
end


class BreakWeapon < TomAbility
	def initialize()
		super("break_weapon")
	end

	def apply(character,target)
		target_effects=Array.new
		hit_roll=character.hitRoll("p",0)
		if target.isHit?(hit_roll,"p")
			target_effects.add(BreakWeaponEffect.new)
		end
		return [nil,target_effects,nil]
	end
end

class BreakWeaponEffect < Effect
	def initialize()
		super("break_weapon_effect")
		@turn=0
		@max_turn=3
	end

	def shouldApply?(target)
		result=@turn==0
		@turn=@turn+1
		return result
	end
	def apply(target)
		target.resistance_actual["p"]=target.damage_actual["p"]-@minor_bonus
	end
	def isOver?(target)
		return @turn==@max_turn
	end	
	def remove(target)
		target.resistance_actual["p"]=target.damage_actual["p"]+@minor_bonus
	end
end


class EffortAbility < TomAbility
	def initialize
		super("effort_ability")
	end

	def apply(character,target)
		character.n_turn_standard_abilities=character.n_turn_standard_abilities++
		self_effects=Array.new
		self_effects.add(TiredCondition.new)
		return [self_effects,nil nil]
	end
end


class AccurateStance < TomAbility
	def initialize
		super("accurate_stance")
	end

	def apply(character,target)
		character.ability_effects.add(AccurateStanceEffect.new)
	end
end

class AccurateStanceEffect < AbilityEffect
	def initialize
		super("accurate_stance_effect")
	end
	def apply(character,target)
		character.hit_actual["p"]=character.hit_actual["p"]+2
	end
	def remove(character,target)
		character.hit_actual["p"]=character.hit_actual["p"]-2
	end
end

class Stun < TomAbility
	def initialize
		super("stun")
	end
	def apply(character,target)
		target_effects=[StunEffect.new]
		return [nil,target_effects,nil]
	end	
end

class StunEffect < TomEffect

end