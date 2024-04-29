# frozen_string_literal: true

class Tournament
  class MediaList < Base

    def self.call(media)
      new(media).call
    end

    def call
      TournamentContext::MediaSerializer.render_as_hash(@media, view: :list)
    end

    private

    attr_reader :media

    def initialize(media)
      @media = media
    end

  end
end
