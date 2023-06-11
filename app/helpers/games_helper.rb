module GamesHelper
  def piece_glyph(piece)
    # This original version (with index) had issues when there was no piece
    # piece.downcase + (piece.downcase == piece ? 'd' : 'l') + (index.odd? ? 'd' : 'l')
    piece.downcase + (piece.downcase == piece ? 'd' : 'l') + 't'
  end

  def square_colour(index)
    index.odd? ? '#d18b47' : '#ffce9e'
  end
end
