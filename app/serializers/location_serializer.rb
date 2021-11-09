class LocationSerializer
  include JSONAPI::Serializer
  set_type :location
  attributes :name,
    :created_at,
    :updated_at
end
