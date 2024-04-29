# frozen_string_literal: true

class Dashboard
  class List

    def self.call
      new.call
    end

    def call
      user_disciplines = UserDiscipline.all
      companies = UserCompany.all

      {
        user_disciplines: UserDisciplineSerializer.render_as_hash(user_disciplines, view: :list),
        companies: UserCompanySerializer.render_as_hash(companies, view: :list)
      }
    end

  end
end
