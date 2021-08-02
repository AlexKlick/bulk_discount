require 'rails_helper'

RSpec.describe 'admin merchants index (/admin/merchants/)' do
  # See /spec/factories.rb for more info on factories created
  create_factories

  describe 'object creation for tests' do
    specify { expect(Customer.all.count).to be_positive }
    specify { expect(Merchant.all.count).to be_positive }
    specify { expect(Item.all.count).to be_positive }
    specify { expect(Invoice.all.count).to be_positive }
    specify { expect(Transaction.all.count).to be_positive }
    specify { expect(InvoiceItem.all.count).to be_positive }
  end

  describe 'as an admin' do
    describe 'when I visit the admin dashboard (/admin)' do
      before { visit admin_index_path }

      specify { expect(current_path).to eq(admin_index_path) }

      it 'displays a header indicating that I am on the admin dashboard' do
        expect(page).to have_content('Admin Dashboard')
      end

      it 'displays a link to the admin merchants index (/admin/merchants)' do
        expect(page).to have_link('Admin Merchants Index')

        click_link 'Admin Merchants Index'

        expect(current_path).to eq(admin_merchants_path)
      end

      it 'displays a link to the admin merchants index (/admin/invoices)' do
        expect(page).to have_link('Admin Invoices Index')

        click_link 'Admin Invoices Index'

        expect(current_path).to eq(admin_invoices_path)
      end
    end
  end
end
