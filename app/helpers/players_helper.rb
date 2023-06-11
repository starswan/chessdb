module PlayersHelper
  def player_name(player)
    "#{player.first_name} #{player.last_name}"
  end
end
