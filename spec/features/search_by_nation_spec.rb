require 'rails_helper.rb'

RSpec.describe "search path" do
  scenario "as a user" do
    visit '/'

    select 'Fire Nation', from: :nation

    click_on "Search For Members"
    
    expect(current_path).to eq(search_path)

    expect(page).to have_content("Population: 100")
  
    expect(page).to have_css(".member", count: 25)

    within(first(".member")) do
      expect(page).to have_css(".name")
      expect(page).to have_css(".image")
      expect(page).to have_css(".allies")
      expect(page).to have_css(".enemies")
      expect(page).to have_css(".affiliations")
    end
  end
end
