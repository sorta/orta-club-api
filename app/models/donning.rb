class Donning < ApplicationRecord
  belongs_to :gay_apparel
  belongs_to :member
  belongs_to :year
  belongs_to :location
end
