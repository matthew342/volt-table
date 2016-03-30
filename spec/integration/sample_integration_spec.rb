require 'spec_helper'
require 'pry'

describe 'Table', type: :feature do
  # An example integration spec, this will only be run if ENV['BROWSER'] is
  # specified.  Current values for ENV['BROWSER'] are 'firefox' and 'phantom'
  describe 'tests' do
    before do
      Factories.custom_user({method: :save}, 'Bob', 'Smith')
      Factories.custom_user({method: :save}, 'Lauren', 'Jones')
      Factories.custom_user({method: :save}, 'John', 'Smith')
      Factories.custom_user({method: :save}, 'Bob', 'John')
      Factories.custom_user({method: :save}, 'Mary', 'Jacobs')
    end

    it 'should load the page', focus: true do
      visit '/'
      expect(page).to have_content('Home')
    end

    it 'should have correct content' do
      visit '/'
      expect(page).to have_content('First Name')
      expect(page).to have_content('Last Name')
      expect(page).to have_content('Email')
    end

    describe 'search bar' do
      before do
        visit '/'
      end

      it 'should show search help' do
        find('.glyphicon-search').click
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
        # expect to not see Mary
      end

      it 'should accept AND queries' do
        fields = all(:css, '.form-control')
        fields[0].set('Bob, Smith')
        # expect correct rows to be shown
      end

      it 'should accept field queries' do
        fields = all(:css, '.form-control')
        fields[0].set('Bob, email:Bob.Barker@sample.com')
        # expect correct rows to be shown
      end
    end

    describe 'headers' do
      before do
        visit '/'
      end

      describe 'per_page' do
        it 'should have correct default values' do
          expect(page).to have_content('Clear All Filters')
          expect(page).to have_content('Show 10')
          click_button('Show 10')
          expect(page).to have_content('10')
          expect(page).to have_content('25')
          expect(page).to have_content('50')
          find("a", :text => "25").click
          #expect 25 elements
          expect(page).to have_content('Show 25')
          click_button('Show 25')
          find("a", :text => "50").click
          #expect 50 elements
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
        find('.glyphicon-search').click
      end
    end


  end
end
