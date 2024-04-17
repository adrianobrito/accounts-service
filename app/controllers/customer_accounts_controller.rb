# app/controllers/customer_accounts_controller.rb
class CustomerAccountsController < ApplicationController
    before_action :set_customer_account, only: [:show, :update]
  
    # GET /products
    def index
      @customer_accounts = CustomerAccount.all
      render json: @customer_accounts
    end

    # GET /customer_accounts/:id
    def show
      render json: @customer_account
    end
  
    # POST /customer_accounts
    def create
      # Fetch the Product based on product_id from the request
      product = Product.find_by(id: params[:product_id])
  
      # If product doesn't exist, return an error
      unless product
        return render json: { error: "Product not found" }, status: :not_found
      end
  
      # Initialize a new CustomerAccount with the product's last_product_price_id and the provided customer_id
      customer_account = CustomerAccount.new(
        customer_id: params[:customer_id],
        product_price_id: product.last_product_price_id
      )
  
      puts customer_account
      # Save the CustomerAccount
      if customer_account.save
        render json: customer_account, status: :created
      else
        render json: customer_account.errors, status: :unprocessable_entity
      end
    end
  
    # PUT /customer_accounts/:id
    def update
      # Check if product_id is provided and differs from the current product_price's product_id
      if params[:product_id] && (@customer_account.product_price&.product_id != params[:product_id])
        # Find the product by the new product_id
        product = Product.find_by(id: params[:product_id])
        unless product
          return render json: { error: "Product not found" }, status: :not_found
        end
        # Update the product_price_id with the new product's last_product_price_id
        @customer_account.product_price_id = product.last_product_price_id
      end
  
      if @customer_account.update(customer_account_params)
        render json: @customer_account
      else
        render json: @customer_account.errors, status: :unprocessable_entity
      end
    end
  
    private
      def set_customer_account
        @customer_account = CustomerAccount.find(params[:id])
      end
  
      def customer_account_params
        params.permit(:customer_id, :product_id)
      end
  end
  