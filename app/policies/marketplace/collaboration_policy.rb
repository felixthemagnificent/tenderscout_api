class Marketplace::CollaborationPolicy < Core::TenderPolicy
  attr_reader :user, :collaboration

  def initialize(user, collaboration)
    @user = user
    @collaboration = collaboration
  end
  
  def apply?
<<<<<<< HEAD
    true || @collaboration.tender.owner?(@user) || @collaboration.tender_collaborators.where(user: @user).try(:first).try(:role)
=======
    @collaboration.tender.owner?(@user) || @collaboration.tender_collaborators.where(user: @user).first.role
>>>>>>> wip;
  end

  def remove?
    apply?
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
