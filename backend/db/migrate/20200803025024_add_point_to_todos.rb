class AddPointToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :point, :integer
  end
end

#rails g migrationを使うことで余計なファイルが作成されない