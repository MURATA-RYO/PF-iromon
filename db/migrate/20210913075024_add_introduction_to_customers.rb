class AddIntroductionToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :introduction, :string
  end
end
