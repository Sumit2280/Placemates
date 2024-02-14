class Opportunity < ApplicationRecord
  belongs_to :company

  has_many :user_applications


  def self.update_status
    d=Date.today
    Opportunity.where.not(status: "closed").find_each do |opportunity|
      if(opportunity.start_date <= d && opportunity.end_date >= d)
        opportunity.status="applicable"
      elsif (d>opportunity.end_date)
        opportunity.status="ongoing"
      else
        opportunity.status="yet_to_start"
      end
    end
  end
end
