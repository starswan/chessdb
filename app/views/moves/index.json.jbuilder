json.array!(@moves) do |move|
  json.extract! move, :id, :game_id, :number, :colour, :fen
  json.url move_url(move, format: :json)
end
