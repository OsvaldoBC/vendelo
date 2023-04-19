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

    test 'render a new product form' do 
        get new_product_path 
        assert_response :success
        assert_select 'form'
    end

    test 'allows to create a new product' do
        post products_path, params: { 
            product: {
                title: 'Nintendo 64',
                description: 'le faltan los cables',
                price: 45
            }
        }
            assert_redirected_to products_path 
    end
    
    test 'does not allows to create a new product with empty fields' do
        post products_path, params: { 
            product: {
                title: '',
                description: 'le faltan los cables',
                price: 45
            }
        }
            assert_response :unprocessable_entity
    end
end