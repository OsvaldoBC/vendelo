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
            assert_equal flash[:notice],'Tu producto se ha guardado correctamente'
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
    
    test 'render an edit product form' do 
        get edit_product_path(products(:PS4))
        assert_response :success
        assert_select 'form'
    end

    test 'allows to update a product' do
        patch product_path(products(:PS4)), params: { 
            product: {
                price: 165
            }
        }
            assert_redirected_to products_path 
            assert_equal flash[:notice],'Tu producto se ha actualizado correctamente'
    end

    test 'does not allows to update a product' do
        patch product_path(products(:PS4)), params: { 
            product: {
                price: nil
            }
        }
            assert_response :unprocessable_entity         
    end
    test 'can delete products' do
            assert_difference('Product.count',-1) do
            delete product_path(products(:PS4))
        end
        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'
    end
end