class AddKindToContact < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :kind
  end
end
