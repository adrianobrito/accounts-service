# app/controllers/customer_accounts_controller.rb
class CustomerAccountsController < ApplicationController
    before_action :set_customer_account, only: [:show, :update]
  
    # GET /customer_accounts/:id
    def show
      render json: @customer_account
    end
  
    # POST /customer_accounts
    def create
      @customer_account = CustomerAccount.new(customer_account_params)
      if @customer_account.save
        render json: @customer_account, status: :created, location: @customer_account
      else
        render json: @customer_account.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /customer_accounts/:id
    def update
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
        params.require(:customer_account).permit(:customer_id, :product_price_id)
      end
  end
  