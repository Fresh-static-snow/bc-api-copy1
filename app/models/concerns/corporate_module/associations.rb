# frozen_string_literal: true

module CorporateModule
  module Associations

    extend ActiveSupport::Concern

    included do
      belongs_to :company, class_name: 'CorporateCompany', optional: true

      has_many :comments, class_name: 'EntityComment', as: :entity, dependent: :destroy

      has_many :corporate_main_participants, class_name: 'CorporateMainParticipants', dependent: :destroy
      has_many :main_participants, through: :corporate_main_participants, source: :user

      has_many :corporate_participants, class_name: 'CorporateParticipants', dependent: :destroy
      has_many :participants, through: :corporate_participants, source: :user
    end

  end
end
