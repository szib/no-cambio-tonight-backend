class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :member_since
  attribute :email, if: :is_current_user?

  def is_current_user?
    object.id === current_user.id
  end
end
