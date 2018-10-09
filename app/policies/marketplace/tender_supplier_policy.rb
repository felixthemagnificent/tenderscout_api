class Marketplace::TenderSupplierPolicy < Marketplace::TenderPolicy
  attr_reader :user, :tender

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
