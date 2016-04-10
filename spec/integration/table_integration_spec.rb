require 'spec_helper'
require 'pry'

describe 'Table', type: :feature do
  # Will only be run if ENV['BROWSER'] is specified.
  # Current values for ENV['BROWSER'] are 'firefox' and 'phantom'
    before do
      Factories.user({method: :save, first_name: 'Bob', last_name: 'Smith'})
      Factories.user({method: :save, first_name: 'Lauren', last_name: 'Jones'})
      Factories.user({method: :save, first_name: 'Jerry', last_name: 'Smith'})
      Factories.user({method: :save, first_name: 'Bob', last_name: 'John'})
      Factories.user({method: :save, first_name: 'Mary', last_name: 'Jacobs'})
    end

    it 'should load the page' do
      visit '/'
      expect(page).to have_content('Home')
    end

    it 'should have correct content' do
      visit '/'
      expect(page).to have_content('Bob')
      expect(page).to have_content('Lauren')
      expect(page).to have_content('John')
      expect(page).to have_content('Bob')
      expect(page).to have_content('Mary')
      expect(page).to have_content('First Name')
      expect(page).to have_content('Last Name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Showing 1 - 5 of 5')
      expect(page).to have_content('Filtered from a total of 5')
    end

    describe 'search bar' do
      before do
        visit '/'
      end

      it 'should show search help' do
        find('.fa-search').click
        expect(page).to have_content('Search Help')
        expect(page).to have_content('first:')
        expect(page).to have_content('last:')
        expect(page).to have_content('email:')
      end

      it 'should be empty' do
        fields = all(:css, '.form-control')
        expect(fields[0].value).to eq('')
      end

      it 'should accept OR queries' do
        fields = all(:css, '.form-control')
        fields[0].set('Bob | Jerry')
        # expect correct rows to be shown
        expect(page).to have_content('Bob')
        expect(page).to have_content('Jerry')
        expect(page).not_to have_content('Mary')
        expect(page).not_to have_content('Lauren')
        expect(page).to have_content('Showing 1 - 3 of 3')
      end

      it 'should accept AND queries' do
        fields = all(:css, '.form-control')
        fields[0].set('Bob, Smith')
        expect(page).to have_content('Bob')
        expect(page).to have_content('Smith')
        expect(page).not_to have_content('Mary')
        expect(page).not_to have_content('Lauren')
        expect(page).not_to have_content('Jerry')
        expect(page).to have_content('Showing 1 - 1 of 1')
      end

      it 'should accept a field query' do
        fields = all(:css, '.form-control')
        fields[0].set('Lauren, email:Lauren.Jones@sample.com')
        # expect correct rows to be shown
        expect(page).not_to have_content('Jerry')
        expect(page).not_to have_content('Bob')
        expect(page).not_to have_content('Mary')
        expect(page).to have_content('Lauren')
        expect(page).to have_content('Showing 1 - 1 of 1')
      end
    end

    describe 'headers' do
      before do
        50.times do
          Factories.user({method: :save})
        end
        visit '/'
      end

      describe 'per_page' do
        it 'should have correct default values', focus: true do
          expect(page).to have_content('Clear All Filters')
          expect(page).to have_content('Show 10')
          expect(page).to have_content('Showing 1 - 10 of 55')
          click_button('Show 10')
          expect(page).to have_content('10')
          expect(page).to have_content('25')
          expect(page).to have_content('50')
        end

        it 'should show 25 rows', focus: true do
          click_button('Show 10')
          find("a", :text => "25").click
          expect(page).to have_content('Show 25')
          expect(page).to have_content('Showing 1 - 25 of 55')
        end

        it 'should show 50 rows', focus: true do
          click_button('Show 10')
          find("a", :text => "50").click
          expect(page).to have_content('Showing 1 - 50 of 55')
          expect(page).to have_content('Show 50')
        end
      end

      describe 'columns shown' do
        it 'should display the correct columns shown' do
          click_button('fields_shown')
          list = Array.new
          list = find_by_id('fields_shown_list').all('li')
          expect(list.size).to eq(3)
          expect(list[0]).to have_content('First Name')
          expect(list[1]).to have_content('Last Name')
          expect(list[2]).to have_content('Email')

        end

        it 'should hide columns when unchecked' do
          click_button('fields_shown')
          uncheck('First Name')
          click_button('fields_shown')
          uncheck('Last Name')
          click_button('fields_shown')
          uncheck('Email')
          expect(page).not_to have_content('First Name')
          expect(page).not_to have_content('Last Name')
          expect(page).not_to have_content('Email')
        end

        it 'should show columns when checked' do
          click_button('fields_shown')
          uncheck('First Name')
          click_button('fields_shown')
          uncheck('Last Name')
          click_button('fields_shown')
          uncheck('Email')
          click_button('fields_shown')
          check('First Name')
          expect(page).to have_content('First Name')
          click_button('fields_shown')
          check('Last Name')
          expect(page).to have_content('Last Name')
          click_button('fields_shown')
          check('Email')
          expect(page).to have_content('Email')
        end
      end
    end

    describe 'filtering' do
      it 'should open filter' do
        visit '/about'
        find('.fa-search').click
      end
    end

end
