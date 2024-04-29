# frozen_string_literal: true

module TimeAgoHelper

  include ActionView::Helpers::DateHelper

  def time_ago
    distance_of_time_in_words_to_now(created_at)
  end

end
