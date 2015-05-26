class ShovelsController < ApplicationController

  def index
    if current_user
      @shovels = Shovel.all
    else
      redirect_to '/'
      flash[:notice] = "You must register or log in before you can do that! Fool!"
    end
  end

  def new
    if current_user
      @shovel = Shovel.new
    else
      redirect_to '/'
      flash[:notice] = "You must register or log in before you can do that! Fool!"
    end
  end

  def create
    @shovel = Shovel.new(shovel_params)
    if @shovel.save
      flash[:notice] = "#{@shovel.name} created successfully!"
      redirect_to shovels_path
    else
      render :new
    end
  end

  def show
    if current_user
      @shovel = Shovel.find(params[:id])
    else
      flash[:notice] = "You must register or log in before you can do that! Fool!"
      redirect_to '/'
    end
  end

  def edit
    if current_user
      @shovel = Shovel.find(params[:id])
    else
      flash[:notice] = "You must register or log in before you can do that! Fool!"
      redirect_to '/'
    end
  end

  def update
    @shovel = Shovel.find(params[:id])
    if @shovel.update(shovel_params)
      flash[:notice] = "#{@shovel.name} updated successfully!"
      redirect_to shovel_path(@shovel)
    else
      render :edit
    end
  end

  def destroy
    @shovel = Shovel.find(params[:id])
    @shovel.destroy
    flash[:notice] = "Deleted shovel: #{@shovel.name}"
    redirect_to shovels_path
  end

  private

  def shovel_params
    params.require(:shovel).permit(:name, :quantity)
  end
end
