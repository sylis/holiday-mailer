class Person < ActiveRecord::Base
  belongs_to :household

  before_create :ensure_household
  after_destroy :remove_empty_household
  
  
  def full_name
    if first_name && last_name
      return "#{first_name} #{last_name}"
    else
      return first_name || last_name
    end
  end
  
  def full_email_address
    if full_name
      "#{full_name} <#{email}>"
    else
      email
    end
  end
    
protected
  def ensure_household
    unless self.household_id
      self.household = Household.create!
    end
  end
  
  def remove_empty_household
    if self.household.people.count(true) == 0
      self.household.destroy
    end
  end
end
