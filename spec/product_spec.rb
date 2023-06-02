
require_relative '../config/environment'


RSpec.describe Product, type: :model do

  describe 'Validations' do
  before(:each) do
    @category = Category.create(name: 'Test Category')
    @product = Product.new(
      name: 'Test',
      price: Money.new(100, 'USD'),
      quantity: 1,
      category: @category
    )
  end

  it 'should save successfully with all four fields set' do
    expect(@product.save).to be true
  end

  it 'should be invalid without a name' do
    @product.name = nil
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end

  it 'should be invalid without a price' do
    @product.price_cents = nil
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end

  it 'should be invalid without a quantity' do
    @product.quantity = nil
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end

  it 'should be invalid without a category' do
    @product.category = nil
    expect(@product.save).to be false
    expect(@product.errors.full_messages).to include("Category can't be blank")
  end
end
end