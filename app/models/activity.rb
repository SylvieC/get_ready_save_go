class Activity < ActiveRecord::Base
  belongs_to :trip

  def index
  end
end
