class MemberPolicy < ApplicationPolicy

  def index?
    false
  end

  def show?
    false
  end

  def create?
    true
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
