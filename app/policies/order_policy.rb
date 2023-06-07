class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    true
  end

  def show?
    true
  end

  def specialshow?
    true
  end

  def create?
    true
  end

  def accept?
    true
  end

  def markascompleted?
    true
  end

  def cancel?
    true
  end

  def update?
    record.user == user
  end

end
