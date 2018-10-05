class SearchMonitorPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.paid?
  end

  def show?
    @user.paid?
  end

  def create?
    @user.standart? || @user.admin?
  end

  def update?
    create?
  end

  def all_results?
    index?
  end

  def preview?
    index?
  end

  def archive?
    index?
  end

  def share?
    index?
  end

  def result?
    index?
  end



  def destroy?
    @user.standart?
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
