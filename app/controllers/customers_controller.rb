# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :update, :destroy]
  
    # GET /customers
    def index
      @customers = Customer.all
      render json: @customers
    end
  
    # GET /customers/:id
    def show
      render json: @customer
    end
  
    # POST /customers
    def create
      @customer = Customer.new(customer_params)
      if @customer.save
        render json: @customer, status: :created, location: @customer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /customers/:id
    def update
      if @customer.update(customer_params)
        render json: @customer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /customers/:id
    def destroy
      @customer.destroy
      head :no_content
    end
  
    private
      def set_customer
        @customer = Customer.find(params[:id])
      end
  
      def customer_params
        params.require(:customer).permit(:name, :address)
      end
  end
  