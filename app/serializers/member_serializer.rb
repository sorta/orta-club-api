class MemberSerializer
  include JSONAPI::Serializer
  set_type :member
  attributes :name_first,
    :name_middle,
    :name_last,
    :birthdate,
    :is_approved,
    :slug,
    :created_at,
    :updated_at
end
