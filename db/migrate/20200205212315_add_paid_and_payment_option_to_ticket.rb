class AddPaidAndPaymentOptionToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :status, :string, default: 'unpaid', null: false
    add_column :tickets, :payment_option, :integer
    add_column :tickets, :payment_time, :datetime
  end
end
