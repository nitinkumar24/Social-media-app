class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :dislikes, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :content, presence: true, length: {maximum: 400}
    has_attached_file :avatar, styles: { original: "960x960>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    has_paper_trail
    after_create :add_mentions

    def add_mentions
        Mention.create_from_text(self)
    end

    def can_update_or_delete user
        self.user_id == user.id
    end

    def liked_by(user_id)
        Like.where(post_id: id, user_id: user_id).length > 0
    end


    def like_string user_id
        if liked_by user_id
            return "Like"
        else
            return "Unlike"
        end

    end


    def disliked_by user_id
        Dislike.where(post_id: id, user_id: user_id).length > 0
    end


    def dislike_string user_id
        if disliked_by user_id
            return "DisLike"
        else
            return "UnDisLike"
        end

    end


end
