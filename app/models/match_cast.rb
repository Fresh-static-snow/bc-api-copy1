# frozen_string_literal: true

# == Schema Information
#
# Table name: match_casts
#
#  id                      :bigint           not null, primary key
#  deleted_at              :datetime
#  backup_commentator_id   :integer
#  cast_analytic_studio_id :integer
#  cast_language_id        :integer
#  cast_setup_id           :integer
#  cast_stream_id          :integer
#  cast_studio_id          :integer
#  host_analytic_id        :integer
#  match_id                :integer
#
# Indexes
#
#  index_match_casts_on_deleted_at  (deleted_at)
#  index_match_casts_on_match_id    (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (cast_analytic_studio_id => cast_analytic_studios.id)
#  fk_rails_...  (cast_language_id => cast_languages.id)
#  fk_rails_...  (cast_studio_id => cast_studios.id)
#  fk_rails_...  (match_id => matches.id)
#
class MatchCast < ApplicationRecord

  self.table_name = :match_casts

  acts_as_paranoid

  include MatchCastModule::Associations

end
