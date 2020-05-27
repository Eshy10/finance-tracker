class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = 'Friend added to list of followed friends'
      redirect_to friendships_friend_list_path
    else
      flash[:alert] = 'An error occured'
    end
  end

  def friend_list
    @friend_lists = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friendships/friend_list' }
        end
        
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'friendships/friend_list' }
        end
      end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a friend name or email to search"
          format.js { render partial: 'friendships/friend_list' }
        end
      end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = 'Friend removed from your list of friends'
    redirect_to friendships_friend_list_path
  end
end
