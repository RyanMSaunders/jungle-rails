require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: 'Test Category')
    end

    it 'saves successfully when all fields are set' do
      @product = Product.new(name: 'Test Product', price: 100, quantity: 10, category: @category)
      expect(@product).to be_valid
    end

    it 'validates presence of name' do
      @product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates presence of price' do
      @product = Product.new(name: 'Test Product', price: nil, quantity: 10, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates presence of quantity' do
      @product = Product.new(name: 'Test Product', price: 100, quantity: nil, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates presence of category' do
      @product = Product.new(name: 'Test Product', price: 100, quantity: 10, category: nil)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end