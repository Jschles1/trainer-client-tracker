class ClientsController < ApplicationController
  def new
    @client = Client.new
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
