class YearSerializer
  include JSONAPI::Serializer
  set_type :year
  attributes :num,
    :created_at,
    :updated_at
  has_many :donnings
end
