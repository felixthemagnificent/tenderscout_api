class Marketplace::TenderQualificationCriteriaSectionPolicy < Marketplace::TenderCompetePolicy

  def bulk_create?
    create?
  end
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
