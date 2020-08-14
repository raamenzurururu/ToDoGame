class V1::TodosController < ApplicationController
  # POST /api/v1/todos
  def create
    todo = Todo.new(todo_params)   #render json: todoのtodoはtodo = Todo.newしたやつ
    if todo.save
      render json: todo, status: :created #todoに保存したデータが入っている
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

  # DELETE /api/v1/todos/:id
  def destroy
    todo = Todo.find(params[:id])
    if todo.destroy
      render json: todo                   #todoにデータが入っている
    end                                   #title, user_id, created_at, updated_at
  end 

  def complete  #todo達成用
    todo = Todo.find(params[:id])
    user = User.find(todo.user_id)

    total_point = user.point.to_i
    total_point += todo.point
    user.point = total_point
    
    total_exp = user.experience_point
    total_exp += todo.point
    user.experience_point = total_exp
    user.update(point: total_point,experience_point: total_exp)
    levelSetting = LevelSetting.find_by(level: user.level + 1)
    if levelSetting.present? && levelSetting.thresold <= user.experience_point
      user.level = user.level + 1
      user.update(level: user.level)
    end

    if todo.destroy
      render json: {todo: todo, user: user}
    end
  end 

  def sort
    params[:todos].each_with_index do |t,i|

    render json: { todo: todo }
  end

  private
    def todo_params
      #pointを送れた
      params.require(:todo).permit(:title, :user_id, :point)   #{"todo"=>{"title"=>"英語", "user_id"=>6, "point"=>2}, "controller"=>"v1/todos", "action"=>"create"} permitted: false>
    end                                                #paramsにはこんだけの情報が入っている
end
