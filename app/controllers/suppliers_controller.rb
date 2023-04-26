class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update]

  def index
    @suppliers = Supplier.all
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o fornecedor'
      render :new
    end
  end

  def edit
  end

  def update  
    if @supplier.update(supplier_params)
      redirect_to supplier_path(@supplier), notice: 'Fornecedor alterado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível alterar o fornecedor'
      render :new
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params 
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
  end
end
