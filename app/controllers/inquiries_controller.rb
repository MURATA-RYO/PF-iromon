class Customers::InquiriesController < ApplicationController
  def index
    @inquiry = Inquiry.new # 入力画面を表示
    render :action => 'index'
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message)) # 入力値のチェック
    if @inquiry.valid? # OK。確認画面を表示
      render :action => 'confirm'
    else
      render :action => 'index' # NG。入力画面を再表示
    end
  end
  
  def thanks
    #@inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message)) # メール送信
     @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
      render :action => 'thanks' # 完了画面を表示
  end
end
