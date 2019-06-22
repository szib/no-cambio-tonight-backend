class ProfileSerializer < ActiveModel::Serializer
  attributes :full_name, :email
  belongs_to :user
end
