class Admin::ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
    @user = User.find(@contact.user_id)
  end

end

