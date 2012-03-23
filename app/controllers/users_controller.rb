
class UsersController < ApplicationController
  include Databasedotcom::Rails::Controller

  def index
    #@users = User.all()[0..19]
    @users = User.query("Id != NULL LIMIT 20")
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    render "show"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if (@user.save)
      redirect_to(@user, :notice => 'User was successfully created.')
    end
  end
end
