# frozen_string_literal: true

class PaginatedList

  def initialize(page: 1, per_page: nil)
    @page_number = page.to_i
    @per_page = (per_page || resources.model.default_per_page).to_i
  end

  private

  attr_reader :page_number, :per_page

  def build_pagination
    {
      current: resources.current_page,
      previous: prev_page,
      next: next_page,
      per_page: resources.limit_value,
      pages: resources.total_pages,
      count: resources.total_count
    }
  end

  def resources
    raise NotImplementedError
  end

  def next_page
    resources.current_page == resources.total_pages ? nil : resources.current_page.next
  end

  def prev_page
    resources.current_page > 1 ? resources.current_page.pred : nil
  end

end
