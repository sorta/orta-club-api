class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :is_admin

  belongs_to :member
end
