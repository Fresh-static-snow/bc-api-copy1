# frozen_string_literal: true

module TournamentModule
  module Colorable

    extend ActiveSupport::Concern

    module ClassMethods

      AVAILABLE_COLORS = {
        '0' => { primary: '#A4262C' },
        '1' => { primary: '#D13438' },
        '2' => { primary: '#F7630C' },
        '3' => { primary: '#FDE300' },
        '4' => { primary: '#8E562E' },
        '5' => { primary: '#00CC6A' },
        '6' => { primary: '#107C10' },
        '7' => { primary: '#038387' },
        '8' => { primary: '#0099BC' },
        '9' => { primary: '#0078D4' },
        '10' => { primary: '#0027B4' },
        '11' => { primary: '#5C2E91' },
        '12' => { primary: '#B146C2' },
        '13' => { primary: '#BF0077' },
        '14' => { primary: '#69797E' },
        '15' => { primary: '#00BCF2' }
      }.freeze

    end

    included do
      include ClassMethods
    end

  end
end
