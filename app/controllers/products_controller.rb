class ProductsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end  

  def create
    @product = Product.new(params.require(:product).permit(:product_name, :product_details, :price))

    if @product.save
      redirect_to products_path, :notice=> 'Product was successfully created.'
    else
      redirect_to new_product_path, :alert=> 'Error! Please try again'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @order = Order.where("product_id = ?", params[:id])

    if @order.count > 0
      redirect_to products_path, :alert => 'Cannot delete product while its order exists.'
    else  
      @product = Product.find(params[:id])

      if @product.destroy
        redirect_to products_path, :notice => 'Product was successfully deleted.'
      else
        redirect_to products_path, :alert => 'Error! Please try again'
      end
    end  
  end
end
