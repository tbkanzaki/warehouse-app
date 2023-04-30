class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update]
  before_action :check_user, only: [:show, :edit, :update]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível cadastrar o pedido'
      render :new
    end
  end

  def show
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível alterar o pedido.'
      render :edit
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def check_user
    if @order.user != current_user
      return redirect_to root_path, alert: "Você não possui acesso a este pedido."
    end
  end
end
