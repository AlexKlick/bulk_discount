class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_five_by_successful_transactions
    joins(:transactions)
      .select('customers.*, count(transactions.id) AS count')
      .where(transactions: { result: :success})
      .group(:id)
      .order('count desc')
      .limit(5)
  end

  # def self.top_five_customers(merchant_id)
  #   joins(invoices: :transactions)
  #     .joins(invoices: :items)
  #     .select('count(transactions.id) as total_transactions, customers.*')
  #     .where('transactions.result = 0')
  #     .where('items.merchant_id = ?', merchant_id)
  #     .group(:id)
  #     .order('total_transactions desc')
  #     .limit(5)
  # end
end
