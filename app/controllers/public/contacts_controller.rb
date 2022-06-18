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
    if @contact.save
      ContactMailer.send_mail(@contact, current_user).deliver_now
      render "thanks"
    else
      render "new"
    end
  end

  def thanks
    @contact = Contact.new(contact_params)
    # ContactMailer.received_email(@contact).delicer
    render "thanks"
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end

end
