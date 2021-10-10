class MemberPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.is_admin || user.id == record.user_id
  end

  def create?
    true
  end

  def update?
    user.is_admin || user.id == record.user_id
  end

  def destroy?
    user.is_admin || user.id == record.user_id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
