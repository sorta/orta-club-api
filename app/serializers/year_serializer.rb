class DonningSerializer
  include JSONAPI::Serializer
  set_type :donning
  attributes
    :num,
    :created_at,
    :updated_at
end
