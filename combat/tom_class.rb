class TomClass < TomBaseCharacter

		attr_reader :ability_list

		def initialize(hit_base,damage_base,dodge_base,st_base,dc_base,resistance_base,movement_base,hp_base,condition_immunities_base,damage_immunities_base,
			ability_trees) 
			super(hit_base,damage_base,dodge_base,st_base,dc_base,resistance_base,movement_base,hp_base,condition_immunities_base,damage_immunities_base)
		end

		def addAbility(ability)
			@ability_list.push(ability)
		end

end



