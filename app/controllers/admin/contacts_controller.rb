class Admin::ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def show
    # @user = User.find(params[:id])
    @contact = Contact.find(params[:id])
  end

end

