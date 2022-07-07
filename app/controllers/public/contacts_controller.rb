class Public::ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.invalid?
      render "new"
    else
      render "confirm"
    end
  end

  def create
    @contact = Contact.new(contact_params)
    # コンタクトにユーザーidを渡す
    @contact.user_id = current_user.id
    if @contact.save
      # ContactMailer.send_mail(@contact).deliver_now
      redirect_to contacts_thanks_path
    else
      render "new"
    end
  end

  # confirmで内容に間違いがあった場合に投稿フォームに戻る
  def back
    @contact = Contact.new(contact_params)
    render "new"
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :user_id, :progress_status)
  end

end
