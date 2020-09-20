class UserSerializer
  include JSONAPI::Serializer

  attributes :email

  belongs_to :member
end
