module ApplicationHelper
  def user_avatar(user)
    if user.photo.present?
      user.photo.url
    else
      image_url 'default_avatar.png'
    end
  end

  def cat_photo(cat)
    if cat.photo.present?
      cat.photo.url
    else
      image_url 'default_cat.png'
    end
  end
end
