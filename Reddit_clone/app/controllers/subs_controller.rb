class SubsController < ApplicationController
  before_action :require_login
  
  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find(params[:id])
    
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to sub_url(@sub)
    end 
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id 
    if @sub.save
      redirect_to sub_url(@sub)
    else 
      flash[:errors] = @sub.errors.full_messages
      render :new 
    end 
      
  end
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
