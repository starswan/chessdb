json.array!(@games) do |game|
  json.extract! game, :id, :white, :black, :date, :opening, :variation, :ecocode, :result
  json.url game_url(game, format: :json)
end
