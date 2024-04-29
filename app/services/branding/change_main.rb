# frozen_string_literal: true

class Branding
  class ChangeMain < Base

    def self.call(params)
      new(params).call
    end

    def call
      change_main
    end

    private

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def change_main
      Branding.where.not(id: params[:id])&.update(visible: false)
      Branding.find(params[:id])&.update(visible: true)
    end

  end
end
