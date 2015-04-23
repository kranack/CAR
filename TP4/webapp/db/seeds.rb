# encoding: UTF-8

# tax rates
tax_rate = Shoppe::TaxRate.create!(:name => "Standard VAT", :rate => 20.0)
exempt_tax = Shoppe::TaxRate.create!(:name => "Exempt VAT", :rate => 0.0)

# delivery services

ds = Shoppe::DeliveryService.create!(:name => "Next Day Delivery", :code => 'ND16', :courier => 'AnyCourier', :tracking_url => 'http://trackingurl.com/track/{{consignment_number}}')
ds.delivery_service_prices.create!(:code => 'Parcel', :min_weight => 0, :max_weight => 1, :price => 5.0, :cost_price => 4.50, :tax_rate => tax_rate)
ds.delivery_service_prices.create!(:code => 'Parcel', :min_weight => 1, :max_weight => 5, :price => 8.0, :cost_price => 7.5, :tax_rate => tax_rate)
ds.delivery_service_prices.create!(:code => 'Parcel', :min_weight => 5, :max_weight => 20, :price => 10.0, :cost_price => 9.50, :tax_rate => tax_rate)

ds = Shoppe::DeliveryService.create!(:name => "Saturday Delivery", :code => 'NDSA16', :courier => 'AnyCourier', :tracking_url => 'http://trackingurl.com/track/{{consignment_number}}')
ds.delivery_service_prices.create!(:code => 'Parcel', :min_weight => 0, :max_weight => 1, :price => 27.0, :cost_price => 24.00, :tax_rate => tax_rate)
ds.delivery_service_prices.create!(:code => 'Parcel', :min_weight => 1, :max_weight => 5, :price => 29.0, :cost_price => 20.00, :tax_rate => tax_rate)
ds.delivery_service_prices.create!(:code => 'Parcel', :min_weight => 5, :max_weight => 20, :price => 37.0, :cost_price => 32.00,:tax_rate => tax_rate)

# categories
books = Shoppe::ProductCategory.create!(:name => 'Books')

def get_file(name, content_type = 'image/jpeg')
	file = ActionDispatch::Http::UploadedFile.new(:tempfile => File.open(File.join('.', 'db', 'seeds_assets', name), 'rb'))
	file.original_filename = name
	file.content_type = content_type
	file
end

pro = books.products.create!(:name => 'Necronomicon', :sku => 'NECRO-666', :description => 'Best seller', :short_description => 'It will make you sad', :weight => 2.23, :price => 149.99, :cost_price => 139.99, :tax_rate => tax_rate, :featured => true)
pro.default_image_file = get_file('necronomicon.jpg')
pro.save!
pro.stock_level_adjustments.create(:description => 'Initial Stock', :adjustment => 10)
pro.product_attributes.create!(:key => 'Manufacturer', :value => 'Yealink', :position => 1)
pro.product_attributes.create!(:key => 'Model', :value => 'T46GN', :position => 1)
pro.product_attributes.create!(:key => 'Colour', :value => 'Black', :position => 1)
pro.product_attributes.create!(:key => 'Lines', :value => '4', :position => 1)
pro.product_attributes.create!(:key => 'Colour Screen?', :value => 'Yes', :position => 1)
pro.product_attributes.create!(:key => 'Power over ethernet?', :value => 'Yes', :position => 1)


