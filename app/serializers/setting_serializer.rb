# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id             :bigint           not null, primary key
#  match_duration :integer          default(60)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class SettingSerializer < Blueprinter::Base

  identifier :id

  fields :match_duration

end
