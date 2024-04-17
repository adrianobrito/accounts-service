class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]
  
    # GET /products
    def index
      @products = Product.all
      render json: @products
    end
  
    # GET /products/:id
    def show
      render json: @product.as_json(
        methods: :last_product_price_value,  # Updated to use the correct method
        except: [:last_product_price_id]
      )
    end
  
    # POST /products
    def create
      # First, initialize the product with the permitted params except for price
      @product = Product.new(product_params.except(:product_price))
      
      # Handle the product price
      if params[:product_price].present?
        new_product_price = ProductPrice.create(product_price: params[:product_price])
        @product.last_product_price_id = new_product_price.id
      end
  
      puts @product
      # Save the product
      if @product.save
        render json: @product, status: :created, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    def update
      # Check if a new price is provided and is different from the current product price
      new_price = params[:product_price].to_d if params[:product_price]
      if new_price && (@product.last_product_price.nil? || new_price != @product.last_product_price.product_price)
        # Create a new ProductPrice if different
        new_product_price = ProductPrice.create(product_price: new_price)
        @product.last_product_price = new_product_price
      end
      
      # Update other product attributes as usual
      if @product.update(product_params)
        render json: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /products/:id
    def destroy
      @product.destroy
      head :no_content
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = Product.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:name, :product_price)
      end
  end
  