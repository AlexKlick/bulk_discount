require 'rails_helper'

RSpec.describe Customer, type: :model do
  # See /spec/factories.rb for more info on factories created
  Merchant.destroy_all
  Customer.destroy_all
  create_factories

  describe 'object creation for tests' do
    specify { expect(Customer.all.count).to be_positive }
    specify { expect(Merchant.all.count).to be_positive }
    specify { expect(Item.all.count).to be_positive }
    specify { expect(Invoice.all.count).to be_positive }
    specify { expect(Transaction.all.count).to be_positive }
    specify { expect(InvoiceItem.all.count).to be_positive }

    it 'can build a customer' do
      customer_1 = create(:customer)

      expect(customer_1.first_name).to be_a(String)
      expect(customer_1.last_name).to be_a(String)
    end
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'class methods' do
    describe '.top_five_by_successful_transactions' do
      it 'returns the customers with the most successful transactions' do
        expected = [customer2, customer4, customer6, customer5, customer3]
        expect(Customer.top_five_by_successful_transactions).to eq(expected)
      end
    end
  end
end
