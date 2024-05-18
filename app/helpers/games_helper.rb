module GamesHelper
  def piece_glyph(piece)
    piece.downcase + (piece.downcase == piece ? 'd' : 'l') + 't'
  end

  def square_colour(index)
    # index.odd? ? '#d18b47' : '#ffce9e'
    index.odd? ? 'dark-square' : 'light-square'
  end
end
