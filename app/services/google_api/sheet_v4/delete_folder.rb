# frozen_string_literal: true

module GoogleApi
  module SheetV4
    class DeleteFolder < Base

      def self.call
        new.call
      end

      def call
        get_directory(drive)
      end

      private

      def get_directory(drive_service)
        existing_folders = drive_service.list_files(
          q: "mimeType='application/vnd.google-apps.folder'"
        )

        unless existing_folders.files.empty?
          existing_folders.files.each do |file|
            delete_folder_contents(drive_service, file.id) if file.mime_type == 'application/vnd.google-apps.folder'

            drive_service.delete_file(file.id)
          end
        end
      end

      def delete_folder_contents(drive_service, folder_id)
        result = drive_service.list_files(q: "'#{folder_id}' in parents", fields: 'files(id, name)')
        files = result&.files

        files&.each do |file|
          delete_folder_contents(drive_service, file.id) if file.mime_type == 'application/vnd.google-apps.folder'

          drive_service.delete_file(file.id)
        end
      end

    end
  end
end
