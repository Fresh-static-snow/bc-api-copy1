# frozen_string_literal: true

require 'google/apis/sheets_v4'
require 'google/apis/drive_v3'

module GoogleApi
  module SheetV4
    class Base

      def sheet
        @sheet ||= create_sheet
      end

      def drive
        @drive ||= create_drive
      end

      def create_sheet
        sheet = Google::Apis::SheetsV4::SheetsService.new
        sheet.authorization = authorize
        sheet
      end

      def create_drive
        drive = Google::Apis::DriveV3::DriveService.new
        drive.authorization = authorize
        drive
      end

      def authorize
        file_path = Rails.root.join('config/client_secret.json')
        unless File.exist?(file_path)
          json_content = JSON.parse(Base64.decode64(ENV.fetch('GOOGLE_ENCODED_SECRET_FILE')))
          json_string = JSON.pretty_generate(json_content)
          File.open(file_path, 'w') do |file|
            file.write(json_string)
          end
        end

        credentials = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: File.open('config/client_secret.json'),
          scope: [Google::Apis::DriveV3::AUTH_DRIVE, Google::Apis::SheetsV4::AUTH_SPREADSHEETS]
        )
        credentials.fetch_access_token!
        credentials
      end

    end
  end
end
