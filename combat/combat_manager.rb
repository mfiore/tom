class CombatManager


	def manageCombat(enemies,party)
		enemies.each do |e|
			initiative=e.rollInitiative
			turn_order.add([e,initiative])
		end
		party.each do |p|
			initiative=p.rollInitiative
			turn_order.add([p,initiative])
		end
		turn_order.sort {|x,y| x[1]<y[1]}
		n_party_dead=0
		n_enemies_dead=0

		character_effects=Hash.new 
		map_effects=Hash.new 
		while n_enemies_dead<enemies.size and n_party_dead<party.size do
			turn_order.each do |member|
				character=member[0]
				if character.canAct?
					character_effects[character]=checkAndApplyEffects(character_effects[character])
					if not character.is_confused and not character.is_berserk
						action=character.chooseAction
						while action.type!="confirm" do
							if action.type=="movement"
								action.path.each do |p|
									$game_player.move_plan(p)
									position=[character.x,character.y]
									map_effects[position]=checkAndApplyEffects(map_effects[position])
								end	
							elsif action.type=="ability"
								action.execute(character,target)
								[self_effects,target_effects,map_effects]=action.getEffects
								self_effects.each do |effect|
									character_effects[character].add(effect)
								end
								target_effects.each do |effect|
									character_effects[target].add(effect)
								end
								map_effects.each do |effect|
									map_effects[effect.x,effect.y].add(effect)
								end
							end
							action=character.chooseAction
						end

					elsif character.is_confused
						actions=chooseConfusedActions(character)
					elsif character.is_berserk
						actions=chooseBerserkActions(character)
					end
				end
			end
		end

	end

	def checkAndApplyEffects(effects)
		still_active=Array.new
		for i in 0 effects.size() 
			effect=effects[i]
			if effect.shouldApply?
				effect.apply
			end
			if not effect.isOver?
				still_active.add(effect)
			end
		end
		still_active
	end
end