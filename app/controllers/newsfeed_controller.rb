class NewsfeedController < ApplicationController

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html{
        @post = Post.new
        @comment=Comment.new
        @comments = Comment.all
        @feed = current_user.feed.limit(50)
      }
      format.js{
        offset = params["offset"]
        if offset
          offset = offset.to_i
        else
          offset = 0
        end

        @new_offset = offset + 10
        @show_load_more = offset < current_user.feed.count
        @feed = current_user.feed.offset(offset).limit(10)
      }
    end

  end

  def users
    @users = User.all.order(name: :desc)
  end

  def profile
    @posts=Post.where(user_id:params[:user_id]).order(created_at: :DESC)
    @comment=Comment.new
    @comments = Comment.all
    user_id=params[:user_id]
    @user=User.find_by_id(user_id)
  end


  def friendrequests
    @friendrequests=Friendrequest.where(receiver_id: current_user.id)
  end


  def follow
    followee_id = params[:followee_id]
    if current_user.can_follow followee_id
      puts "in follow"
      Friendrequest.create(:receiver_id => followee_id,:sender_id => current_user.id)
      # FollowMapping.create(:followee_id => followee_id, :follower_id => current_user.id)
    else
    end
    return redirect_to '/users'
  end

  def un_follow
    followee_id = params[:followee_id]
    if current_user.can_un_follow followee_id
      FollowMapping.where(:followee_id => followee_id, :follower_id => current_user.id).first.destroy
    else
    end
    return redirect_to '/users'
  end

  def delete_request
    followee_id = params[:followee_id]
    if current_user.can_delete_request followee_id
      Friendrequest.where(:receiver_id => followee_id, :sender_id => current_user.id).first.destroy
    else
    end
    return redirect_to '/users'
  end

  def accept_request
    follower_id = params[:follower_id]
    FollowMapping.create(:followee_id => current_user.id, :follower_id => follower_id)
    Friendrequest.where(:receiver_id => current_user.id, :sender_id => follower_id).first.destroy
    return redirect_to '/users'
  end

  def reject_request
    follower_id = params[:follower_id]
    Friendrequest.where(:receiver_id => current_user.id, :sender_id => follower_id).first.destroy
    return redirect_to '/users'
  end


  def ajax
    render :json => {text: "text"}
  end

end
