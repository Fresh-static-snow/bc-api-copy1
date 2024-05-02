# frozen_string_literal: true

require 'securerandom'
require 'faker'

permissions = PermissionService.special_permissions_by_ids(%i[calendar_day calendar_week calendar_month event_comment])
role_viewer = Role.find_or_create_by(title: 'Co-worker')
role_viewer.update(permissions: permissions)

permissions = PermissionService.special_permissions_by_ids(%i[calendar_day calendar_week calendar_month calendar_quarter calendar_year event_view create_entity event_comment])
role_editor = Role.find_or_create_by(title: 'Editor')
role_editor.update(permissions: permissions)

permissions = PermissionService.special_permissions_by_ids(%i[calendar_day calendar_week calendar_month calendar_quarter calendar_year event_view event_comment dashboard_view])
role_editor = Role.find_or_create_by(title: 'C Level')
role_editor.update(permissions: permissions)

permissions = PermissionService.special_permissions_by_ids(%i[calendar_day calendar_week calendar_month calendar_quarter calendar_year event_view create_entity event_comment dashboard_view dashboard_all])
role_admin = Role.find_or_create_by(title: 'Super Admin')
role_admin.update(permissions: permissions)

user_discipline = []
user_discipline << UserDiscipline.find_or_create_by(title: 'Staff')
user_discipline << UserDiscipline.find_or_create_by(title: 'Participant')
user_discipline << UserDiscipline.find_or_create_by(title: 'Main Participant')
user_discipline << UserDiscipline.find_or_create_by(title: 'Media Representative')
user_discipline << UserDiscipline.find_or_create_by(title: 'Commentator')
user_discipline << UserDiscipline.find_or_create_by(title: 'Analytic')
user_discipline << UserDiscipline.find_or_create_by(title: 'Manager')

user_company = UserCompany.find_or_create_by(title: 'Maincast')
user_company.save

user = User.find_or_create_by(email: ENV.fetch('ADMIN_EMAIL', 'calendar@maincast.com')) do |user|
  user.email = ENV.fetch('ADMIN_EMAIL', 'calendar@maincast.com')
  user.password = ENV.fetch('ADMIN_PASSWORD', 'password1!')
  user.password_confirmation = ENV.fetch('ADMIN_PASSWORD', 'password1!')
  user.nick = 'admin'
  user.first_name = 'Maincast'
  user.last_name = 'Admin'
  user.confirmed = true
  user.confirmed_at = Time.now.utc
  user.company = user_company
end

user.user_disciplines = [user_discipline[6]]
user.roles = [role_admin]
user.save

if Rails.env.staging? || Rails.env.development?
  autotests_user = User.find_or_create_by(email: 'autotests@maincast.com') do |autotests_user|
    autotests_user.email = 'autotests@maincast.com'
    autotests_user.password = ENV.fetch('ADMIN_PASSWORD', 'password1!')
    autotests_user.password_confirmation = ENV.fetch('ADMIN_PASSWORD', 'password1!')
    autotests_user.nick = 'autotests'
    autotests_user.first_name = 'autotests'
    autotests_user.last_name = 'admin'
    autotests_user.confirmed = true
    autotests_user.company = user_company
  end

  autotests_user.user_disciplines = [user_discipline[6]]
  autotests_user.roles = [role_admin]
  autotests_user.save
end

max_id = User.maximum(:id)
max_id_val = max_id.nil? ? 1 : max_id + 1
ActiveRecord::Base.connection.execute("ALTER SEQUENCE users_id_seq RESTART WITH #{max_id_val};")

# Create cast languages
[
  { name: 'Ukrainian', keyword: 'uk' },
  { name: 'English', keyword: 'en' },
  { name: 'Russian', keyword: 'ru' },
  { name: 'French', keyword: 'fr' },
  { name: 'German', keyword: 'de' }
].each do |lang|
  l = CastContext::Language.find_or_create_by(keyword: lang[:keyword])
  l.name = lang[:name]
  l.save
end

# Create tournament types
%w[Homecast TIER1 TIER2 TIER3 Vmixcast].each do |t|
  TournamentContext::Type.find_or_create_by({ name: t }).save
end

['Analysts 8.1', 'Analysts 8.2', 'Analysts 9.2', 'Analysts 10'].each do |t|
  CastContext::AnalyticStudio.find_or_create_by({ name: t} ).save
end

['Cast 9.1', 'Cast 9.2', 'Cast 8.2', 'Cast 10', 'Poland', 'Setup 1', 'Setup 2', 'Setup 3', 'Setup 4', 'Remote1', 'Remote2', 'Remote3', 'Remote4'].each do |t|
  CastContext::Studio.find_or_create_by({ name: t} ).save
end

# Create Channels
%w[dota2mc_ua dota2mc_ua2 dota2mc_ua3 dota2mc_ua4 dota2mc_ua5 dota2mc_ua6 csgomc_ua csgomc_ua2 csgomc_ua3 csgomc_ua4 csgomc_ua5 csgomc_ua6 maincastcom maincast_main valorantmc_ua].each do |t|
  CastContext::Channel.find_or_create_by({ name: t} ).save
end

company = CorporateCompany.find_or_create_by(keyword: 'maincast') do |new_company|
  new_company.title = 'Maincast'
  new_company.keyword = 'maincast'
end
company.save

company.cover.attach(
  io: File.open(Rails.root.join('db/img/maincast.png')),
  filename: 'maincast.png',
  content_type: 'image/png'
)

Setting.find_or_create_by(match_duration: 60)
