class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = @user.stocks
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
end
