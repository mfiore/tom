class PlayerInput
	def initialize
		@planning_map=PlanningMap.new
		@mouse=MouseController.new
		@characters_to_move=Array.new
		@character_semaphore=Mutex.new
		@id_movement=0
	end
	def update

	 	if @mouse.isInBoundary?
	 		#p sprintf( ' in boundary')
		    mouse_coords=@mouse.mouseToMapCoordinates
		   	mouse_triggers=@mouse.getKeyPressed
		    if GameData.isNormalMode?
		    #	p sprintf(' in normal mode')
		    	processNormal(mouse_coords[0],mouse_coords[1],mouse_triggers[0],mouse_triggers[1])
		    elsif GameData.isCombatMode?

		    end
		end
  	end

 
  	def isTileFree?(x,y)
  		#p sprintf(' in tile obstacle')
  		$game_map.passable?(x,y,2) or $game_map.passable?(x,y,4) or $game_map.passable?(x,y,6) or $game_map.passable?(x,y,8)
  		true
  	end
  	def processNormal(x,y,left_t,right_t)
		@mouse.processedTrigger
	    event_id=$game_map.event_id_xy(x,y)
   		start_node=PathMapNode.new($game_player.x,$game_player.y)
   		if left_t
		    if event_id!=0
		    	path_planning_info=$game_map.events[event_id].getPathPlanningInfo
		    	pos=path_planning_info[0]
		    	orientation=path_planning_info[1]
		    	p sprintf('pos and or are '+pos.to_s+' '+orientation.to_s)
		    	if pos!=nil
		    		if pos==6
		    			p sprintf(' increasing x')
		    			x=x+1
		    		elsif pos==4
		    			x=x-1
		    		elsif pos==2
		    			y=y+1
		    		elsif pos==8
		    			y=y-1
		    		end
		    	end
		    end
		    if  isTileFree?(x,y)
	    		goal_node=PathMapNode.new(x,y)
		    end
		    if goal_node!=nil
		    	path=@planning_map.aStar(start_node,goal_node) {|a,b| (a.x-b.x).abs + (a.y-b.y).abs }
		    	if path!=nil
		    		if orientation!=nil 
		    			if orientation==4
		    				path.push(17)
		    			elsif orientation==6
		    				path.push(18)
		    			elsif orientation==8
		    				path.push(19)
		    			elsif orientation==2
		    				path.push(16)
		    			end
		    		end
		    		$game_player.move_plan(path)
		    	end
		    end
		end
  	end
end