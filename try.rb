class Prova 
  def initialize()

#    pictures=$game_map.screen.pictures
#    picture=pictures[0]
 #   picture.show('inventory',0,0,0,100,100,255,0) 

  #  $game_message.add("Mouse is in boundary? "+mouse.isInBoundary?.to_s)   
  #  $game_message.add("Mouse position is "+pos[0].to_s+" "+pos[1].to_s)
  #  mouse_coord=mouse.mouseToMapCoordinates
  #  $game_message.add("Mouse coordinates "+mouse_coord[0].to_s+" "+mouse_coord[1].to_s)
  #  $game_message.add("let's see who's the boss")
  #  leader=$game_party.leader
  #  $game_message.add(leader.name)
  #  $game_message.add($game_player.x.to_s)
  #  $game_message.add($game_player.real_x.to_s)
  #  $game_message.face_name=$game_actors[1].face_name
  #  $game_message.face_index=$game_actors[1].face_index
  
    #m=MovementChecker.new(path)
    #$game_player.set_path(path)
  
    path=[3,3]
    $game_player.move_plan(path)
   end
end	
