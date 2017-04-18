require 'rails_helper'

RSpec.feature "Test the product details page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "click on a product link should show the product details" do
    # ACT
    visit root_path
    all("h4")[0].click

    #DEBUG
    sleep 2
    save_screenshot

    #VERIFY
    expect(page).to have_content "Reviews"
    expect(page).to have_content "Average Rating"
  end


end
