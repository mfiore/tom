class Game_Character < Game_CharacterBase
	def move_plan(path)
		move_route=RPG::MoveRoute.new()
		move_route.repeat=false
		move_route.list.clear
		path.push(0)
		path.each do |node|
		  command=RPG::MoveCommand.new
		  command.code=node
		  move_route.list.push(command)
		end
		force_move_route(move_route)
	end
end	

module DataManager
	def self.create_game_objects
	    $game_temp          = Game_Temp.new
	    $game_system        = Game_System.new
	    $game_timer         = Game_Timer.new
	    $game_message       = Game_Message.new
	    $game_switches      = Game_Switches.new
	    $game_variables     = Game_Variables.new
	    $game_self_switches = Game_SelfSwitches.new
	    $game_actors        = Game_Actors.new
	    $game_party         = Game_Party.new
	    $game_troop         = Game_Troop.new
	    $game_map           = Game_Map.new
	    $game_player        = Game_Player.new
  		$player_input = PlayerInput.new
  		GameData::setNormalMode
  end
end


class Scene_Base
  def update_basic
    Graphics.update
    Input.update
    $player_input.update
    update_all_windows
  end
end


class Game_Event
	def getPathPlanningInfo
	  if list[0] 
	  	line=list[0].parameters[0]
	  	if line
	  		if line[0]=='<'
	  			words=line[1..-2].each_line(' ')
	  			words.next
	  			position=words.next
	  			words.next
	  			orientation=words.next
	  			return [position.to_i,orientation.to_i]
	  		end
	  	end
	  end
	  return [nil,nil]
	end
end
