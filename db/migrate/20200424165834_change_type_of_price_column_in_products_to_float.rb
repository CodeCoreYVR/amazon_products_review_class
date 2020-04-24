class ChangeTypeOfPriceColumnInProductsToFloat < ActiveRecord::Migration[6.0]
  # def change
  #   change_column :products, :price, :float
  # end
  
  def up 
    change_column :products, :price, :float
  end

  def down 
    change_column :products, :price, :integer
  end
end
