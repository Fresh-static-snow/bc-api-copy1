# frozen_string_literal: true

class Segment
  class MediaList < Base

    def self.call(media)
      new(media).call
    end

    def call
      SegmentContext::MediaSerializer.render_as_hash(@media)
    end

    private

    attr_reader :media

    def initialize(media)
      @media = media
    end

  end
end
