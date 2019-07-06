class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :member_since
  attribute :email, if: :is_current_user?
  
  attribute :picture do
    if object.id.even?
      gender = 'men'
    else
      gender = 'women'
    end

    picture_id = object.id % 98

    pictures = {}
    pictures["large"] = "https://randomuser.me/api/portraits/#{gender}/#{picture_id}.jpg" 
    pictures["medium"] = "https://randomuser.me/api/portraits/med/#{gender}/#{picture_id}.jpg" 
    pictures["thumb"] = "https://randomuser.me/api/portraits/thumb/#{gender}/#{picture_id}.jpg" 
    pictures
  end

  attribute :full_name do
    "#{object.first_name} #{object.last_name}"
  end

  attribute :number_of_organised_events do
    object.organised_events.size
  end

  attribute :number_of_attended_events do
    object.attended_events.size
  end

  def is_current_user?
    object.id === current_user.id
  end
end
