class GayApparelSerializer
  include JSONAPI::Serializer
  set_type :'gay-apparel'
  attributes :name,
    :created_at,
    :updated_at
end
