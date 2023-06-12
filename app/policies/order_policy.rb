class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.driver?
        scope.all
      else
        scope.where(customer_id: user.id)
      end
    end
  end

  def new?
    user.driver? == false
  end

  def driverindex?
    user.driver?
  end

  def show?
    user.driver? == false
  end

  def specialshow?
    user.driver? == false
  end

  def create?
    user.driver? == false
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
    record.customer_id == user.id
  end

end
