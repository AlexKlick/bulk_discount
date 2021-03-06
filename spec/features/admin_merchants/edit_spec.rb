require 'rails_helper'

RSpec.describe 'admin merchants edit (/admin/merchants/merchant_id/edit)' do
  let!(:merchant1) { create(:enabled_merchant) }
  let!(:merchant2) { create(:enabled_merchant) }
  let!(:merchant3) { create(:enabled_merchant) }

  describe 'object creation for tests' do
    specify { expect(Merchant.all.count).to be_positive }
  end

  describe 'as an admin' do
    describe 'when I visit the admin merchants edit page (/admin/merchants/merchant_id/edit)' do
      before { visit edit_admin_merchant_path(merchant1) }

      specify { expect(current_path).to eq(edit_admin_merchant_path(merchant1)) }
      specify { expect(page).to have_no_content('Update successful!') }

      it 'displays a form filled in with the existing merchant attribute information' do
        expect(page).to have_field(:merchant_name, with: merchant1.name)
        expect(page).to have_no_field(:merchant_name, with: merchant2.name)
        expect(page).to have_no_field(:merchant_name, with: merchant3.name)
        expect(page).to have_button('Submit')
      end

      describe 'when I update the information in the form and click submit' do
        before do
          fill_in :merchant_name, with: 'Stompy Feet'
          click_button 'Submit'
        end

        it 'redirects me to the merchants admin show page' do
          expect(current_path).to eq(admin_merchant_path(merchant1))
        end

        it 'displays the updated information' do
          expect(page).to have_content('Stompy Feet')
          expect(page).to have_no_content(merchant2.name)
          expect(page).to have_no_content(merchant3.name)
        end

        it 'displays a flash message stating that the information has been successfully updated' do
          expect(page).to have_content('Update successful!')
        end
      end
    end
  end
end
