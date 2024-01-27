class AddIndexesToCitizens < ActiveRecord::Migration[7.0]
  def change
    add_index :citizens, :full_name
    add_index :citizens, :email
    add_index :citizens, :cpf
    add_index :citizens, :cns
  end
end
