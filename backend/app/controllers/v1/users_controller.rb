class V1::UsersController < ApplicationController
    def index
      if params[:uid] 
        user = User.find_by(uid: params[:uid])
        todos = user.todos.order(sort: "ASC")
        rewards = user.rewards.order(sort: "ASC")
        render json: {user: user, todos: todos, rewards: rewards}
        todo = {"title" => "","point" => ""}
        reward = {"title" => "","point" => ""}
      end
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :uid, :name)
      end
end