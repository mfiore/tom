class GameData

	def self.setBattleMode
		@game_mode="battle"
	end
	def self.setNormalMode
		@game_mode="normal"
	end
	def self.isBattleMode?
		@game_mode=="battle"
	end
	def self.isNormalMode?
		@game_mode=="normal"
	end
end