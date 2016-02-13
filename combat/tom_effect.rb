class TomEffect
	attr_reader :name

	def initialize(name)
		@name=name
	end

	def shouldApply?(target)
		return true
	end
	def apply(target)
		raise 'this method should be overridden and apply the effect to the current target'
	end
	def isOver?(target)
		return false
	end
	def remove(target)
		raise 'this method should be overriden and remove the effect from the current target'
	end
end


class TomAbilityEffect 
	attr_reader :name

	def initialize(name)
		@name=name
	end

	def shouldApply?(character, target)
		return true
	end
	def apply(character, target)
		raise 'this method should be overridden and apply the effect to the current target'
	end
	def isOver?(character, target)
		return false
	end
	def remove(character, target)
		raise 'this method should be overriden and remove the effect from the current target'
	end
end