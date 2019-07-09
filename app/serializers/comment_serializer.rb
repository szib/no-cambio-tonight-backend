class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment_text
  belongs_to :author, serializer: UserSerializer
end
