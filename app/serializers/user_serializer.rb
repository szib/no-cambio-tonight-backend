class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :member_since
  attribute :email, if: :is_current_user?
  
  attribute :picture do
    picture_id = object.id % 98
    case object.gender
    when 1
      gender = 'men'
    when 2
      gender = 'women'
    else
      gender = 'lego'
      picture_id = object.id % 9
    end

    pictures = {}
    pictures["large"] = "https://randomuser.me/api/portraits/#{gender}/#{picture_id}.jpg" 
    pictures["medium"] = "https://randomuser.me/api/portraits/med/#{gender}/#{picture_id}.jpg" 
    pictures["thumb"] = "https://randomuser.me/api/portraits/thumb/#{gender}/#{picture_id}.jpg" 
    pictures
  end

  attribute :gender do
    case object.gender
    when 1
      'male'
    when 2
      'female'
    else
      '--'
    end
  end

  attribute :full_name do
    "#{object.first_name} #{object.last_name}"
  end

  def is_current_user?
    object.id === current_user.id
  end
end
