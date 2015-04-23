# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Spree::Core::Engine.load_seed if defined?(Spree::Core)
#Spree::Auth::Engine.load_seed if defined?(Spree::Auth)


books = Spree::TaxCategory.create!(:name => "Books")
shipping_category = Spree::ShippingCategory.find_by_name!("Default")


default_attrs = {
	:available_on => Time.zone.now
}

products = [
	{
		:name => "Harry Potter",
		:description => "Harry Potter book",
		:tax_category => books,
		:shipping_category => shipping_category,
		:price => 15.99,
		:eur_price => 14,
	},
]

products.each do |product|
	eur_price = product_attrs.delete(:eur_price)
	Spree::Config[:currency] = "USD"
	default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
	product = Spree::Product.create!(default_attrs.merge(product_attrs))
	Spree::Config[:currency] = "EUR"
	product.reload
	product.price = eur_price
	product.shipping_category = default_shipping_category
	product.save!
end

Spree::Config[:currency] = "USD"
