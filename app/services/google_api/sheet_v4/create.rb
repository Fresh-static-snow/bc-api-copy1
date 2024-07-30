# frozen_string_literal: true

module GoogleApi
  module SheetV4
    class Create < Base

      def self.call(period)
        new.call(period)
      end

      def call(period) # rubocop:disable Metrics/AbcSize
        folder_name = "MainCast Sheets"
        sheet_name = "MainCast BroadcastCalendar #{Time.zone.now.year}"

        folder_id = create_or_get_directory(drive, folder_name)
        spreadsheet_id = create_or_update_spreadsheet(drive, folder_id, sheet_name)

        sheets = sheet.get_spreadsheet(spreadsheet_id)&.sheets

        months = if period == :month
                   (1..12).to_a
                 else
                   current_month = Time.now.strftime("%m").to_i
                   if current_month > 1 && current_month < 12
                     [current_month - 1, current_month, current_month + 1]
                   elsif current_month == 1
                     [current_month, current_month + 1]
                   elsif current_month == 12
                     [current_month - 1, current_month]
                   end
                 end

        months.map do |month|
          month = "0#{month}" if month < 10
          parsed_date = Time.zone.parse("#{Time.zone.now.year}-#{month}-01")
          worksheet_name = "#{parsed_date.strftime('%b')} #{parsed_date.strftime('%y')}"

          sheet_to_delete = sheets&.find { |sheet| sheet.properties.title == worksheet_name }
          if sheet_to_delete
            clear_request = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new(
              requests: [
                Google::Apis::SheetsV4::Request.new(
                  update_cells: {
                    range: {
                      sheet_id: sheet_to_delete.properties.sheet_id
                    },
                    fields: 'userEnteredValue'
                  }
                )
              ],
              include_values_in_response: false
            )
            sheet.batch_update_spreadsheet(spreadsheet_id, clear_request)
          end

          unless sheet_to_delete
            new_worksheet_request = Google::Apis::SheetsV4::AddSheetRequest.new(
              properties: Google::Apis::SheetsV4::SheetProperties.new(
                title: worksheet_name
              )
            )

            add_worksheet_request = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new(
              requests: [
                Google::Apis::SheetsV4::Request.new(add_sheet: new_worksheet_request)
              ],
              include_spreadsheet_in_response: false
            )

            sheet.batch_update_spreadsheet(spreadsheet_id, add_worksheet_request)
          end

          row_index = 2

          matches_data = []
          matches_data << ['Date', 'Time', 'Game', 'Event', 'Main Participant', 'Media Representative', 'Format',
                           'Match', 'Language', 'Analytic Studio', 'Studio', 'Channels', 'Commentators', 'Analytics',
                           'Staff']

          user = User.find(1)

          data = Calendar::List.call({ focused_date: "#{Time.zone.now.year}-#{month}-01", scope: 'month' }, user)
          data.each do |item|
            disciplines = item[:disciplines]
            disciplines&.each do |d|
              discipline = d[:discipline]

              tournaments = d[:tournaments]
              tournaments&.each do |t|
                t['matches'].each do |m|
                  discipline_name = discipline[:title]
                  t_title = t[:title]

                  main_participants = []
                  t[:main_participants]&.map do |p|
                    main_participants << p[:display_name]
                  end

                  media_representatives = []
                  t[:media_representatives]&.map do |p|
                    media_representatives << p[:display_name]
                  end

                  m_format = m[:format]
                  m_teams = "#{m[:team_one] || 'TBD'} vs #{m[:team_two] || 'TBD'}"

                  if m[:match_casts].present?
                    m[:match_casts].each do |cast|
                      commentators = []
                      cast[:commentators]&.map do |commentator|
                        commentators << commentator[:display_name]
                      end

                      analytics = []
                      cast[:analytics]&.map do |analytic|
                        analytics << analytic[:display_name]
                      end

                      staff_members = []
                      cast[:staff_members]&.map do |staff|
                        staff_members << staff[:display_name]
                      end

                      channels = []
                      cast[:channels]&.map { |channel| channels << channel[:name] }

                      languages = cast[:language].present? ? cast[:language][:name] : nil
                      analytic_studios = cast[:analytic_studio].present? ? cast[:analytic_studio][:name] : nil
                      studios = cast[:studio].present? ? cast[:studio][:name] : nil

                      matches_data << [
                        item[:date],
                        m[:start_time],
                        discipline_name,
                        t_title,
                        main_participants.reject(&:blank?).join(', '),
                        media_representatives.reject(&:blank?).join(', '),
                        m_format,
                        m_teams,
                        languages,
                        analytic_studios,
                        studios,
                        channels.reject(&:blank?).join(', '),
                        commentators.reject(&:blank?).join(', '),
                        analytics.reject(&:blank?).join(', '),
                        staff_members.reject(&:blank?).join(', ')
                      ]
                    end
                  else
                    matches_data << [
                      item[:date],
                      m[:start_time],
                      discipline_name,
                      t_title,
                      main_participants.reject(&:blank?).join(', '),
                      media_representatives.reject(&:blank?).join(', '),
                      m_format,
                      m_teams, nil, nil, nil, nil, nil, nil, nil
                    ]
                  end

                  row_index += 1
                end
              end
            end

            row_index += 1
          end

          range = "#{worksheet_name}!A1:O#{row_index}"
          sheet.update_spreadsheet_value(
            spreadsheet_id,
            range,
            Google::Apis::SheetsV4::ValueRange.new(values: matches_data),
            value_input_option: 'RAW',
            include_values_in_response: false
          )
        end

        sheets = sheet.get_spreadsheet(spreadsheet_id)&.sheets
        filtered_sheets = sheets.select do |s|
          s.properties.title.match?(/^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s\d{2}$/)
        end

        # Delete sheets that don't match the criteria
        sheets&.each do |s|
          next if filtered_sheets.include?(s)

          sheet.batch_update_spreadsheet(
            spreadsheet_id,
            Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new(
              requests: [{ delete_sheet: { sheet_id: s.properties.sheet_id } }],
              include_values_in_response: false
            )
          )
        end

        reorder_sheet(spreadsheet_id)

        "https://docs.google.com/spreadsheets/d/#{spreadsheet_id}"
      rescue StandardError => e
        Sentry.capture_exception(e)
        Rails.logger.error("GoogleApi::Sheet::Create: #{e.message}")
      end

      private

      def create_or_get_directory(drive_service, folder_name) # rubocop:disable Metrics/AbcSize
        existing_folders = drive_service.list_files(
          q: "mimeType='application/vnd.google-apps.folder' and name='#{folder_name}'"
        )

        if existing_folders.files.empty?
          folder_metadata = Google::Apis::DriveV3::File.new(
            name: folder_name,
            mime_type: 'application/vnd.google-apps.folder'
          )
          folder = drive_service.create_file(folder_metadata, fields: 'id')

          folder_id = folder.id
        else
          existing_folder = existing_folders.files.first

          folder_id = existing_folder.id
        end

        user_has_access_to_folder?(drive_service, folder_id, 'viktor.kliui@27n.gg') ||
          add_folder_permissions(drive_service, folder_id, 'viktor.kliui@27n.gg')

        user_has_access_to_folder?(drive_service, folder_id, 'oleg.marko@27n.gg') ||
          add_folder_permissions(drive_service, folder_id, 'oleg.marko@27n.gg')

        user_has_access_to_folder?(drive_service, folder_id, 'i.snagovskiy@maincast.com') ||
          add_folder_permissions(drive_service, folder_id, 'i.snagovskiy@maincast.com')

        user_has_access_to_folder?(drive_service, folder_id, 'v.voronova@maincast.com') ||
          add_folder_permissions(drive_service, folder_id, 'v.voronova@maincast.com')

        folder_id
      end

      def reorder_sheet(spreadsheet_id) # rubocop:disable Metrics/AbcSize
        sheets = sheet.get_spreadsheet(spreadsheet_id)&.sheets
        if sheets
          sorted_sheets = sheets.sort_by do |sheet|
            month = sheet.properties.title.scan(/([a-zA-Z]+)/).first
            Date::ABBR_MONTHNAMES.index(month[0]) || 1
          end

          requests = sorted_sheets.each_with_index.map do |sheet, index|
            Google::Apis::SheetsV4::Request.new(
              update_sheet_properties: {
                properties: {
                  sheet_id: sheet.properties.sheet_id,
                  index: index
                },
                fields: 'index'
              }
            )
          end

          batch_update_request = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new(
            requests: requests,
            include_values_in_response: false
          )
          sheet.batch_update_spreadsheet(spreadsheet_id, batch_update_request)
        end
      end

      def create_or_update_spreadsheet(drive_service, folder_id, spreadsheet_name)
        existing_spreadsheets = drive_service.list_files(
          q: "mimeType='application/vnd.google-apps.spreadsheet' \
              and name='#{spreadsheet_name}' and '#{folder_id}' in parents"
        )

        if existing_spreadsheets.files.empty?
          create_spreadsheet(drive_service, folder_id, spreadsheet_name)
        else
          existing_spreadsheets.files.first.id
        end
      end

      def create_spreadsheet(drive_service, folder_id, spreadsheet_name)
        spreadsheet = Google::Apis::SheetsV4::Spreadsheet.new
        spreadsheet.properties = Google::Apis::SheetsV4::SpreadsheetProperties.new(title: spreadsheet_name)

        spreadsheet_file_metadata = Google::Apis::DriveV3::File.new(
          name: spreadsheet_name,
          mime_type: 'application/vnd.google-apps.spreadsheet',
          parents: [folder_id]
        )

        new_sheet = drive_service.create_file(spreadsheet_file_metadata, fields: 'id')
        new_sheet.id
      end

      def add_folder_permissions(drive_service, folder_id, user_email)
        permission = Google::Apis::DriveV3::Permission.new(
          type: 'user',
          role: 'writer',
          email_address: user_email
        )

        drive_service.create_permission(folder_id, permission, fields: 'id')
      end

      def user_has_access_to_folder?(drive_service, folder_id, user_email)
        permissions = drive_service.list_permissions(folder_id, fields: 'permissions(id,type,emailAddress)')
        permissions&.permissions&.any? { |p| p.type == 'user' && p.email_address == user_email }
      end

    end
  end
end
