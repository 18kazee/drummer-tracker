class DrummerArtist < ApplicationRecord
  belongs_to :drummer
  belongs_to :artist
end
