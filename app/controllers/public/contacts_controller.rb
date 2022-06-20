class Public::ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render "new"
    else
      render "confirm"
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      # ContactMailer.send_mail(@contact).deliver_now
      redirect_to contacts_thanks_path
    else
      render "new"
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :user_id)
  end

end
