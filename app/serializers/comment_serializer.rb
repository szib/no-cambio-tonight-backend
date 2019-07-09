class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text, :created_at, :updated_at
  belongs_to :author, serializer: UserSerializer
end
