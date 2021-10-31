class ConversationsController < ApplicationController
  def new
    @receipients = User.all - [current_user]
  end

  def create
    @receipient = User.find(params[:user_id])
    receipt = current_user.send_message(@receipient, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def destroy
    current_user.mailbox.conversations.find(params[:id]).destroy
    redirect_to conversations_path
  end
end
