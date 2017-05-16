class ClientsController < ApplicationController


  def index
    @clients = current_user.clients
  end

  def new
    @client = current_user.clients.build
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :phone, :age, :weight, :goal, :weight_change)
  end
end
