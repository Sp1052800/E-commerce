class ProductsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]
  def index
    @product = Product.all
    respond_to do |format|
      format.html
      format.csv{send_data @product.to_csv}
      format.json {send_data json: @product.to_json}
    end
  end

  def new
    @product = Product.new
  end
  def create
     image_attributes = product_params[:image]["photo"]
     product_params.delete(:image)
     @product = Product.new(product_params)
     if @product.save
        image_attributes.each do |each_image|
          image = Image.new(photo: each_image, product: @product)
          image.save(validate: false)
        end
        redirect_to products_path
        else
          render :new
     end
  end
  def edit
    @product=Product.find(params[:id])
  end
  def update
    @product=Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render:edit
    end 
  end

  def show
  end
  def destroy
    @product=Product.find(params[:id])
    if @product.destroy
      redirect_to products_path
    end
  end

  private
  def product_params
    params.require(:product).permit!
  end
end
