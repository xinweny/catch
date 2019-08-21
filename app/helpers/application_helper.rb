module ApplicationHelper
  def user_avatar(user)
    if user.photo.present?
      user.photo
    else
      image_url 'default_avatar.png'
    end
  end
end
