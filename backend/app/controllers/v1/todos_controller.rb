require_relative '../../domain/calc_user_level.rb'

class V1::TodosController < ApplicationController
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created 
    else
      if todo.errors.present?
        render json: { error_msg: todo.errors.full_message }, status: :unprocessable_entity
      else
        render json: todo.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    todo = Todo.find(params[:id])
    todo.update(todo_params)
    render json: todo
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo.destroy
      render json: todo                  
    end                      
  end 

  def complete  
    todo = Todo.find(params[:id])
    user = User.find(todo.user_id)

    total_point = user.point.to_i
    total_point += todo.point
    user.point = total_point
    
    total_exp = user.experience_point
    total_exp += todo.point
    user.experience_point = total_exp
    user.update(point: total_point,experience_point: total_exp)
    user_level = calc_user_level(user, total_exp)
    if todo.destroy
      render json: {todo: todo, user: user, untilPercentage: user_level[:until_percentage], untilLevel: user_level[:until_level]}
    end
  end 

  def sort
    params[:todo].each_with_index do |t,i|
      @todo = Todo.find(t[:id])
      @todo.update( sort: i )
    end
    render json: {result: "ok"}
  end

  private
    def todo_params
      params.require(:todo).permit(:id, :title, :user_id, :point, :sort)   
    end                                               
end
