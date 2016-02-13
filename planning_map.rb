class PathMapNode
	include Comparable

	attr_reader :x, :y, :f_score
	attr_writer :f_score
	def initialize(x,y)
		@x=x.round
		@y=y.round
		@f_score=0
	end
	def coords
		[x,y]
	end
	def <=>(other)
		x_comp=self.x <=> other.x
		y_comp=self.y <=> other.y

		if (x_comp!=0)
			return x_comp
			else return y_comp
		end
	end
	def dist(other)
		return 1
	end
end

class PlanningMap
	def initialize()
	end
	def calculateNeighbors(x,y)
		neighbors=Array.new
		if (x>0)
			if $game_map.passable?(x-1,y,4)
				neighbors.push(PathMapNode.new(x-1,y))
			end
		end
		if (x<$game_map.width-1)
			if ($game_map.passable?(x+1,y,6))
				neighbors.push(PathMapNode.new(x+1,y))
			end
		end
		if (y>0)
			if ($game_map.passable?(x,y-1,8))
				neighbors.push(PathMapNode.new(x,y-1))
			end
		end
		if (y<$game_map.height-1)
			if ($game_map.passable?(x,y+1,2))
				neighbors.push(PathMapNode.new(x,y+1))
			end
		end
		neighbors
	end

	def aStar(start,goal,&heuristic)
		infinity=999999

	    p sprintf('started astar from %d %d to %d %d ',start.x,start.y,goal.x,goal.y) # output to console

		closed_set=Array.new
		open_set=PQueue.new([start]) {|a,b| a.f_score>b.f_score}
		predecessor=Hash.new
		g_score=Hash.new
		g_score[start.coords]=0
		f_score=Hash.new
		f_score[start.coords]=heuristic.call(start,goal)
		while not open_set.empty?
			current_node=open_set.pop
		 	#p sprintf('current node is %f %f',current_node.x,current_node.y)
		 	#p sprintf('goal node is %f %f',goal.x,goal.y)
			if (current_node==goal)
				p sprintf('goal reached')
				g_score.each do |k,v|
		#			p sprintf('for node %f %f gscore is %f',k[0],k[1],v)
				end	
				f_score.each do |k,v|
		#			p sprintf('for node %f %f fscore is %f',k[0],k[1],v)
				end

				return reconstruct_path(predecessor,goal)
			end
			closed_set.push(current_node)
		#	p sprintf('added to closed set')
			current_neighbors=calculateNeighbors(current_node.x,current_node.y)
		#	p sprintf('checking neighbors')
			current_neighbors.each do |neighbor|
		#		p sprintf('neighbor is %f %f',neighbor.x,neighbor.y)
				next if closed_set.include?(neighbor)
		#		p sprintf('neighbor not close')
				test_g_score=g_score[current_node.coords] + current_node.dist(neighbor)
		#		p sprintf('got g_score: %f',test_g_score)
				if not open_set.include?(neighbor)
		#			p sprintf('open set doesnt include neighbor')
					open_set.push(neighbor)
					g_score[neighbor.coords]=infinity
		#			p sprintf('we push it with infinity score')
				end
		#		p sprintf(' comparing test g score with old g score')
				compare_g_score=g_score[neighbor.coords]
		#		p sprintf('neighbor is still %f %f',neighbor.x,neighbor.y)
				if test_g_score<g_score[neighbor.coords]
		#			p sprintf('test_g_score is lower')
					predecessor[neighbor.coords]=current_node
					g_score[neighbor.coords]=test_g_score
					f_score[neighbor.coords]=g_score[neighbor.coords]+heuristic.call(neighbor,goal)
					neighbor.f_score=f_score[neighbor.coords]
		#			p sprintf('updated info')
				end
				
			end
		end
		p sprintf('no path found')
		return nil
	end
	def reconstruct_path(predecessor,goal)
		#p sprintf('reconstruct_path')
		path=Array.new
		path.push(goal)
		node=goal
		predecessor.each do |k,v|
		#	p sprintf('for node %s %s pred is %f %f',k[0],k[1],v.x,v.y)
		end
		#p sprintf('node coords are %d %d',node.x, node.y)
		first_pred=predecessor.fetch(node.coords)
		#p sprintf('predecessor is %d %d',first_pred.x,first_pred.y)
		while predecessor[node.coords]!=nil do 
		#	p sprintf('in pred loop')

			path.push(predecessor[node.coords])
			node=predecessor[node.coords]
		end
		path.each do |p|
		#	p sprintf('path %f %f',p.x,p.y)
		end
		path.reverse!
		direction_path=Array.new
		for i in 1..path.size-1 do
			if path[i].x>path[i-1].x 
				direction_path.push(3)
			elsif path[i].x<path[i-1].x
				direction_path.push(2)
			elsif path[i].y<path[i-1].y
				direction_path.push(4)
			else
				direction_path.push(1)
			end
		end
	direction_path
	end

end

