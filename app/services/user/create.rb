# frozen_string_literal: true

class User
  class Create < Base

    include SendNotify

    attr_accessor :resource, :current_user

    def self.call(user_params, current_user)
      new(user_params, current_user).call
    end

    def call
      with_transaction do
        create_user
      end

      collect_errors(resource)

      send_admin_notify(resource, :create, false) unless resource.errors.any?

      resource
    end

    private

    attr_reader :user_params

    def initialize(user_params, current_user)
      @user_params = user_params
      @current_user = current_user

      super()
    end

    def create_user
      @resource = User.new(user_params)
      @resource.invite! if @resource.save
      process_image
    end

    def process_image # rubocop:disable Metrics/AbcSize
      processed_image = ImageProcessing::MiniMagick
                        .source(user_params[:avatar])
                        .resize_to_fill(300, 300)
                        .convert("webp")
                        .call

      @resource&.avatar&.purge
      resource.reload.avatar.attach(
        io: File.open(processed_image.path),
        filename: "#{user_params[:avatar].original_filename}.webp",
        content_type: "image/webp"
      )
    rescue StandardError => e
      Sentry.capture_exception(e)
      Rails.logger.error "Image processing error: #{e.message}"
    end

  end
end
