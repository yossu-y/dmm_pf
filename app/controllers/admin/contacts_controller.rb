class Admin::ContactsController < ApplicationController

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
    @user = User.find(@contact.user_id)
  end

  def update
     @contact = Contact.find(params[:id])
     if @contact.update(contact_params)
       redirect_to request.referer, notice: "進捗を更新しました！"
     end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :user_id, :progress_status)
  end

end

