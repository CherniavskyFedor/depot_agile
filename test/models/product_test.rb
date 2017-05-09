require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My book Title",
                                            description: "yyy",
                                            image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    product.price = 0

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "My cool book", description: "yyy", price: 1, image_url: image_url)
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg https://a.b.c/x/y/z/fred.gif }
    bad = %w{fred.doc fred.gif/more fred.gif.more}
    ok.each do |name|
      #puts [name, new_product(name), new_product(name).valid?].inspect --- vozrawayemie danie vivodit v consol`
      #a = new_product(name)
      #a.valid?
      #puts a.errors.inspect
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      assert new_product(name).invalid? "#{name} shouldn't be valid... will be stope, use more correct valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title, description: "yyy", price: 1, image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.t('errors.messages.taken')], product.errors[:title]
  end

  test "product is not valid without a unique titl" do
    product = Product.new(title: 'short', description: "yyy", price: 1, image_url: "fred.gif")
    #product.invalid?
    #puts product.errors.inspect
    #puts product.errors[:title].inspect
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]
  end
end
