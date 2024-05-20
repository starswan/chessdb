json.array!(@moves) do |move|
  json.extract! move, :move, :from, :to, :piece, :number, :fen
  # json.url move_url(move, format: :json)
end
