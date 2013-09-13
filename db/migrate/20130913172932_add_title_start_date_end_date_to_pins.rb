class AddTitleStartDateEndDateToPins < ActiveRecord::Migration
  def change
    add_column :pins, :title, :string
    add_column :pins, :start_date, :datetime
    add_column :pins, :end_date, :datetime
    add_index  :pins, :end_date
  end
end
