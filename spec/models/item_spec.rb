require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, enabled: true, merchant: @merchant1)
    @item2 = create(:item, enabled: true, merchant: @merchant1)
    @item3 = create(:item, enabled: false, merchant: @merchant1)
  end

  describe 'class methods' do
    describe '.all_enabled' do
      it 'returns ONLY items where enabled is true' do
        expect(Item.all_enabled).to eq([@item1, @item2])
        expect(Item.all_enabled).to_not include([@item3])
      end
    end

    describe '.all_disabled' do
      it 'returns ONLY items where enabled is false' do
        expect(Item.all_disabled).to eq([@item3])
        expect(Item.all_enabled).to_not include([@item1, @item2])
      end
    end
  end
end
