require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  # See /spec/factories.rb for more info on factories created
  create_factories

  specify { expect(Customer.all.count).to be_positive }
  specify { expect(Merchant.all.count).to be_positive }
  specify { expect(Item.all.count).to be_positive }
  specify { expect(Invoice.all.count).to be_positive }
  specify { expect(Transaction.all.count).to be_positive }
  specify { expect(InvoiceItem.all.count).to be_positive }

  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    statuses = { pending: 0, packaged: 1, shipped: 2 }
    it { should define_enum_for(:status).with(statuses) }

    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end
  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
