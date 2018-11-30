class Song < ActiveRecord::Base
    validates :title, presence: true
    validates :released, inclusion: { in: [ true, false ] }
    validates :release_year, presence: true, if: :released?,
               numericality: {
                  only_integer: true,
                  less_than_or_equal_to: ->(_song) { Date.current.year }
               }
    validate :repeated_song?


    private

    def repeated_song?
        @song = Song.find_by(title: title)
        if @song
            if @song.release_year == release_year && @song.artist_name == artist_name
            errors.add(:title, "Artist cannot release the same song twice in same year")
            end
        end
    end
    
    def released?
        released
    end


end
