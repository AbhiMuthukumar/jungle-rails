require 'rails_helper'

RSpec.describe Product, type: :model do

  before do
    @cat = Category.find_or_create_by! name: 'Apparel'
  end

  context 'Passing all mandatory fields to Category' do
    it "should save the record and return the id" do
      @product = @cat.products.new({name:'Sun Glasses', price: '23.45', quantity: 5})
      @product.save!
      expect(@product.id).to be_present
    end
  end

  context 'Creating product without a name' do
    it "should return error as name cannot be blank" do
      @product = @cat.products.new({price: 32.14, quantity: 2})
      @product.save
      expect(@product.errors.full_messages.first).to eq("Name can't be blank")
    end
  end

  context 'Creating product without a price' do
    it "should return error as price cannot be blank" do
      @product = @cat.products.new({name: 'Sun Glasses', price: nil, quantity: 2})
      @product.save
      expect(@product.errors.full_messages.include?("Price can't be blank")).to eq(true)
    end
  end

  context 'Creating product without quantity' do
    it "should return error as quantity cannot be blank" do
      @product = @cat.products.new({name: 'Sun Glasses', price: 32.15, quantity: nil})
      @product.save
      expect(@product.errors.full_messages.include?("Quantity can't be blank")).to eq(true)
    end
  end

  context 'Creating product without Category' do
    it "should return error as category cannot be blank" do
      @product = Product.new({name: 'Sun Glasses', price: 32.15, quantity: 2})
      @product.save
      expect(@product.errors.full_messages.include?("Category can't be blank")).to eq(true)
    end
  end



end
