class MemberPolicy < ApplicationPolicy

  def index?
    false
  end

  def show?
    user.id == record.user.id
  end

  def create?
    true
  end

  def update?
    user.id == record.user.id
  end

  def destroy?
    user.id == record.user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
