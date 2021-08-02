FactoryBot.define do
  factory :customer do
    first_name { Faker::Movies::HarryPotter.spell }
    last_name  { Faker::Movies::HarryPotter.house }
  end

  factory :invoice do
    customer
    traits_for_enum(:status)
  end

  factory :item do
    name { Faker::Movies::HarryPotter.location }
    description { Faker::Movies::LordOfTheRings.location }
    unit_price { Faker::Number.binary(digits: 5) }
    enabled { Faker::Boolean.boolean }
    merchant
  end

  factory :invoice_item do
    quantity { rand(20) }
    unit_price { rand(10_000) }
    invoice
    item
    traits_for_enum(:status)
  end

  factory :merchant do
    name { Faker::Movies::HarryPotter.character }

    factory :enabled_merchant do
      enabled { true }
    end

    factory :disabled_merchant do
      enabled { false }
    end
  end

  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-') }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    invoice
  end
end

def create_factories
  # CUSTOMERS
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }
  let!(:customer3) { create(:customer) }
  let!(:customer4) { create(:customer) }
  let!(:customer5) { create(:customer) }
  let!(:customer6) { create(:customer) }

  # MERCHANTS
  let!(:merchant1) { create(:enabled_merchant) }
  let!(:merchant2) { create(:enabled_merchant) }
  let!(:merchant3) { create(:enabled_merchant) }
  let!(:merchant4) { create(:disabled_merchant) }
  let!(:merchant5) { create(:disabled_merchant) }
  let!(:merchant6) { create(:enabled_merchant) }

  # ITEMS
  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant2) }
  let!(:item3) { create(:item, merchant: merchant3) }
  let!(:item4) { create(:item, merchant: merchant4) }
  let!(:item5) { create(:item, merchant: merchant5) }
  let!(:item6) { create(:item, merchant: merchant6) }

  # INVOICES
  let!(:invoice1) { create(:invoice, :completed, customer: customer1) }

  let!(:invoice2a) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice2b) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice2c) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice2d) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice2e) { create(:invoice, :completed, customer: customer2) }

  let!(:invoice3) { create(:invoice, :completed, customer: customer3) }

  let!(:invoice4a) { create(:invoice, :completed, customer: customer4) }
  let!(:invoice4b) { create(:invoice, :completed, customer: customer4) }
  let!(:invoice4c) { create(:invoice, :completed, customer: customer4) }
  let!(:invoice4d) { create(:invoice, :completed, customer: customer4) }

  let!(:invoice5a) { create(:invoice, :completed, customer: customer5) }
  let!(:invoice5b) { create(:invoice, :completed, customer: customer5) }

  let!(:invoice6a) { create(:invoice, :completed, customer: customer6, created_at: "2021-07-29T17:30:05+0700") }
  let!(:invoice6b) { create(:invoice, :completed, customer: customer6, created_at: "2021-07-27T17:30:05+0700") }
  let!(:invoice6c) { create(:invoice, :completed, customer: customer6, created_at: "2021-07-25T17:30:05+0700") }

  # TRANSACTIONS
  let!(:transaction1) { create(:transaction, :failed, invoice: invoice1) }

  let!(:transaction2a) { create(:transaction, :success, invoice: invoice2a) }
  let!(:transaction2b) { create(:transaction, :success, invoice: invoice2b) }
  let!(:transaction2c) { create(:transaction, :success, invoice: invoice2c) }
  let!(:transaction2d) { create(:transaction, :success, invoice: invoice2d) }
  let!(:transaction2e) { create(:transaction, :success, invoice: invoice2e) }

  let!(:transaction3) { create(:transaction, :success, invoice: invoice3) }

  let!(:transaction4a) { create(:transaction, :success, invoice: invoice4a) }
  let!(:transaction4b) { create(:transaction, :success, invoice: invoice4b) }
  let!(:transaction4c) { create(:transaction, :success, invoice: invoice4c) }
  let!(:transaction4d) { create(:transaction, :success, invoice: invoice4d) }

  let!(:transaction5a) { create(:transaction, :success, invoice: invoice5a) }
  let!(:transaction5b) { create(:transaction, :success, invoice: invoice5b) }

  let!(:transaction6a) { create(:transaction, :success, invoice: invoice6a) }
  let!(:transaction6b) { create(:transaction, :success, invoice: invoice6b) }
  let!(:transaction6c) { create(:transaction, :success, invoice: invoice6c) }

  # INVOICE ITEMS
  let!(:invoice_item1a) { create(:invoice_item, :pending, item: item1, invoice: invoice1, quantity: 2, unit_price: 10) } # potential_revenue = 20
  let!(:invoice_item1b) { create(:invoice_item, :pending, item: item1, invoice: invoice1, quantity: 5, unit_price: 20) } # potential_revenue = 100
    #=> merchant1_potential_revenue = 120 (but actual = 0; failed transaction)

  let!(:invoice_item2a) { create(:invoice_item, :shipped, item: item2, invoice: invoice2a, quantity: 4, unit_price: 10) } # potential_revenue = 40
  let!(:invoice_item2b) { create(:invoice_item, :shipped, item: item2, invoice: invoice2a, quantity: 1, unit_price: 20) } # potential_revenue = 20
  let!(:invoice_item2c) { create(:invoice_item, :shipped, item: item2, invoice: invoice2b, quantity: 1, unit_price: 20) } # potential_revenue = 20
  let!(:invoice_item2d) { create(:invoice_item, :shipped, item: item2, invoice: invoice2c, quantity: 1, unit_price: 20) } # potential_revenue = 20
  let!(:invoice_item2e) { create(:invoice_item, :shipped, item: item2, invoice: invoice2d, quantity: 1, unit_price: 20) } # potential_revenue = 20
  let!(:invoice_item2f) { create(:invoice_item, :shipped, item: item2, invoice: invoice2e, quantity: 1, unit_price: 20) } # potential_revenue = 20
    #=> merchant2_potential_revenue = 140

  let!(:invoice_item3a) { create(:invoice_item, :packaged, item: item3, invoice: invoice3, quantity: 1, unit_price: 10) } # potential_revenue = 10
  let!(:invoice_item3b) { create(:invoice_item, :packaged, item: item3, invoice: invoice3, quantity: 5, unit_price: 20) } # potential_revenue = 100
    #=> merchant3_potential_revenue = 110

  let!(:invoice_item4a) { create(:invoice_item, :shipped, item: item4, invoice: invoice4a, quantity: 3, unit_price: 10) } # potential_revenue = 30
  let!(:invoice_item4b) { create(:invoice_item, :shipped, item: item4, invoice: invoice4a, quantity: 2, unit_price: 20) } # potential_revenue = 40
  let!(:invoice_item4c) { create(:invoice_item, :shipped, item: item4, invoice: invoice4b, quantity: 1, unit_price: 20) } # potential_revenue = 20
  let!(:invoice_item4d) { create(:invoice_item, :shipped, item: item4, invoice: invoice4c, quantity: 1, unit_price: 20) } # potential_revenue = 20
  let!(:invoice_item4e) { create(:invoice_item, :shipped, item: item4, invoice: invoice4d, quantity: 1, unit_price: 20) } # potential_revenue = 20
    #=> merchant4_potential_revenue = 130

  let!(:invoice_item5a) { create(:invoice_item, :packaged, item: item5, invoice: invoice5a, quantity: 5, unit_price: 10) } # potential_revenue = 50
  let!(:invoice_item5b) { create(:invoice_item, :packaged, item: item5, invoice: invoice5a, quantity: 3, unit_price: 20) } # potential_revenue = 60
  let!(:invoice_item5c) { create(:invoice_item, :packaged, item: item5, invoice: invoice5b, quantity: 2, unit_price: 20) } # potential_revenue = 40
    #=> merchant5_potential_revenue = 150

  let!(:invoice_item6a) { create(:invoice_item, :shipped, item: item6, invoice: invoice6a, quantity: 6, unit_price: 10) } # potential_revenue = 60
  let!(:invoice_item6b) { create(:invoice_item, :shipped, item: item6, invoice: invoice6a, quantity: 5, unit_price: 20) } # potential_revenue = 100
  let!(:invoice_item6c) { create(:invoice_item, :shipped, item: item6, invoice: invoice6b, quantity: 6, unit_price: 10) } # potential_revenue = 60
  let!(:invoice_item6d) { create(:invoice_item, :shipped, item: item6, invoice: invoice6b, quantity: 10, unit_price: 20) } # potential_revenue = 200
  let!(:invoice_item6e) { create(:invoice_item, :shipped, item: item6, invoice: invoice6c, quantity: 6, unit_price: 10) } # potential_revenue = 60
  let!(:invoice_item6f) { create(:invoice_item, :shipped, item: item6, invoice: invoice6c, quantity: 10, unit_price: 20) } # potential_revenue = 200
    #=> merchant6_potential_revenue = 680
end
