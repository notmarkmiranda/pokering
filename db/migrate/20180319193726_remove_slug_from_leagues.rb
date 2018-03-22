class RemoveSlugFromLeagues < ActiveRecord::Migration[5.1]
  def change
    remove_column :leagues, :slug
  end
end
