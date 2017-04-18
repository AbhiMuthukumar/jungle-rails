require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "adding a product should update the cart in nav bar" do
    visit root_path
    all("article.product")[rand(9)].find("footer").all("a")[0].click
    sleep 2
    save_screenshot
    expect(page).to have_content "My Cart (1)"
  end
end
