require_relative '../../domain/user_level.rb'

class V1::UsersController < ApplicationController
  def index
    if params[:uid]
      user = User.find_by(uid: params[:uid])
      if !user.present?
        render json: {}
      else
        todos = user.todos.order(sort: "ASC")
        rewards = user.rewards.order(sort: "ASC")
        total_exp = user.experience_point
        user_level = calc_user_level(user, total_exp)
        render json: {user: user, todos: todos, rewards: rewards, untilPercentage: user_level[:until_percentage], untilLevel: user_level[:until_level]}
      end
    else
      @users = User.all
      render json: @users
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      if reward.errors.present?
        render json: { error_msg: reward.errors.full_message }, status: :unprocessable_entity
      end
      render json: user.errors, status: :unprocessable_entity
    end 
  end 

  private
    def user_params
      params.require(:user).permit(:email, :uid, :name)
    end
end
