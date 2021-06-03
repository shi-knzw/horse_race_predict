class User < ApplicationRecord
  
  has_secure_password
  
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}

  
  def posts
    return Post.where(user_id: self.id)
  end
  
  def user_likes_count
    return Like.where(user_id: self.id).count
  end

end

