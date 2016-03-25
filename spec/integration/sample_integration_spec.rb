require 'spec_helper'

describe 'Table', type: :feature do
  # An example integration spec, this will only be run if ENV['BROWSER'] is
  # specified.  Current values for ENV['BROWSER'] are 'firefox' and 'phantom'
  describe 'tests' do
    before do
      # Factories.custom_user({method: :save}, 'Bob', 'Smith')
    end

    it 'should load the page' do
      visit '/'
      expect(page).to have_content('Home')
    end

    it 'should have correct content' do
      visit '/'
      expect(page).to have_content('Clear All Filters')
      expect(page).to have_content('Show 10')
      expect(page).to have_content('First Name')
      expect(page).to have_content('Last Name')
      expect(page).to have_content('Email')
    end

    describe 'search bar' do
      it 'should show search help' do
        visit '/'
        find('.glyphicon-search').click
        expect(page).to have_content('Search Help')
        expect(page).to have_content('first:')
        expect(page).to have_content('last:')
        expect(page).to have_content('email:')
      end

      it 'should be empty' do
        visit '/'
        fields = all(:css, '.form-control')
        expect(fields[0].value).to eq('')
      end

      it 'should accept OR queries' do
        visit '/'
        fields = all(:css, '.form-control')
        fields[0].set('Bob | Jerry')
        # expect correct rows to be shown
        # expect to not see Mary
      end

      it 'should accept AND queries' do
        visit '/'
        fields = all(:css, '.form-control')
        fields[0].set('Bob, Smith')
        # expect correct rows to be shown
      end

      it 'should accept field queries' do
        visit '/'
        fields = all(:css, '.form-control')
        fields[0].set('Bob, email:Bob.Barker@sample.com')
        # expect correct rows to be shown
      end
    end

    describe 'filtering' do
      it 'should filter '
    end


  end
end
