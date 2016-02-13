class TomAbility
	attr_reader :name
	def initialize(name)
		@name=name
	end
	def execute(character,target)

		if target 
		applied_effects_to_target=checkAndApplyAbilityEffects(character.ability_effects,character,target)
		applied_effects_to_character=checkAndApplyAbilityEffects(target.ability_effects,target,character)
		end
		apply(character,target)

		if target
		removeAppliedAbilityEffects(applied_effects_to_target,character,target)
		removeAppliedAbilityEffects(applied_effects_to_character,target,character)
		end

		[self_effects,target_effects,map_effects]=applyAbility(character,target)

		character.ability_effects=notOverEffects(character)
		if target
		target.ability_effects=notOverEffects(target)
		end
		return [self_effects,target_effects,map_effects]
	end
	def apply(character,target)
	   raise 'this method should be overriden'
	end

	def checkAndApplyAbilityEffects(effects,character,target)
		applied_effects=Array.new
		effects.each do |effect|
			if effect.shouldApply(character,target)
				effect.apply(character,target)
				applied_effects.push(effect)
			end
		end
		return applied_effects
	end

	def removeAppliedAbilityEffects(effects,character,target)
		effects.each do |effect|
			applied_effects.remove(character,target)
		end
	end

	def notOverEffects(character)
		still_active=Array.new
		character.ability_effects.each do |effect|
			if not effect.isOver?
				still_active.add(effect)
			end
		end
		return still_active
	end
end