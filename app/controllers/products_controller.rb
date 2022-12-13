class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    #index muestra todos los registros
    @products = Product.all
    #Simepre me trae una relacion de instnacias guardadas
    #en un ARRAY
  end

  def show
    #muestra un registro
    @product = Product.find(params[:id])
  end

  def new
    #Instancia un obejto en blanco para ser llenado a traves de un formulario
    @product = Product.new
  end

  def create
    #Se activa al presionar el boton create del formulario
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save 
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    #Se ejecuta en el mismo formulario de new, pero esta vez trae los datos de una instancia
    @product = Product.find(params[:id])
  end

  def update
    #Se ejecuta al presionar el boton update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to @product
  end

  def destroy
    #Elimina un registro
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

end
