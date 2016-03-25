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

    it 'should be empty' do
      visit '/'
      fields = all(:css, '.form-control')
      expect(fields[0].value).to eq('')
      fields[0].set('Bob')
    end

    it 'should show query inputs' do
      visit '/'
      find('.glyphicon-search').click
      expect(page).to have_content('Search Help')
    end
  end
end
