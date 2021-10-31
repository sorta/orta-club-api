class DonningSerializer
  include JSONAPI::Serializer
  set_type :donning
  attributes
    :created_at,
    :updated_at

    belongs_to :gay_apparel
    belongs_to :member
    belongs_to :year
end
