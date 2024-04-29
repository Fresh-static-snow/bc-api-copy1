# frozen_string_literal: true

# == Schema Information
#
# Table name: sponsors
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#
# Indexes
#
#  index_sponsors_on_deleted_at  (deleted_at)
#
class Sponsor < ApplicationRecord

  self.table_name = :sponsors

  acts_as_paranoid

  include Filterable
  include SponsorModule::Associations
  include SponsorModule::Scopes
  include SponsorModule::Validations

end
