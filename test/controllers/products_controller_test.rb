require 'test_helper'
class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'Render a list of products' do
        get products_path
        assert_response :success
        assert_select '.product', 2
    end

    test 'Render a detailed product page' do
        get product_path(products(:PS4))
        assert_response :success
        assert_select '.title','PS4 fat'
        assert_select '.description','PS4 en buen estado'
        assert_select '.price','150'
    end
end