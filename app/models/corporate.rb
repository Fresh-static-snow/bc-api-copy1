# frozen_string_literal: true

# == Schema Information
#
# Table name: corporates
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text
#  end_at      :datetime
#  location    :string
#  name        :string           not null
#  start_at    :datetime
#  ui_template :jsonb
#  visible     :boolean          default(FALSE), not null
#  company_id  :integer
#
# Indexes
#
#  index_corporates_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => corporate_companies.id)
#
class Corporate < ApplicationRecord

  self.table_name = :corporates

  acts_as_paranoid

  before_validation :set_default_fields_if_empty

  include Attachable
  include Filterable
  include CorporateModule::Colorable
  include CorporateModule::Validations
  include CorporateModule::Associations
  include CorporateModule::Scopes

  private

  def set_default_fields_if_empty
    self.end_at ||= start_at if start_at.present?
    self.ui_template = (ui_template.presence || AVAILABLE_COLORS.values.sample)
  end

end
