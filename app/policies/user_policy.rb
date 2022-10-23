class UserPolicy < ApplicationPolicy

  def index?
    user.is_admin
  end

  def show?
    user.is_admin || user.id == record.id
  end

  def create?
    true
  end

  def update?
    user.is_admin || user.id == record.id
  end

  def destroy?
    user.is_admin || user.id == record.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
