class AddUniqueIndexToContactsCpf < ActiveRecord::Migration[7.2]
  def change
    add_index :contacts, :cpf, unique: true
  end
end
