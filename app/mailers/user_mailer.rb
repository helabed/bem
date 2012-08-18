class UserMailer < ActionMailer::Base

  SUPPORT     = 'beytelmouneh.lebanon@gmail.com'
  ORDERS      = 'orders@beytelmouneh.com'
  ACCOUNTS    = 'accounts@beytelmouneh.com'
  ADMIN       = 'admin@beytelmouneh.com'
  WEBMASTER   = 'webmaster@beytelmouneh.com'
  FULFILLMENT = 'fulfillment@beytelmouneh.com'

  # Blind Carbon Copy (BCC) list
  BCC_LIST    = [ADMIN, WEBMASTER, FULFILLMENT]

  default :from => SUPPORT

  def registration_confirmation(user)
    @user = user
    @greeting = "Hi #{user.name}"

    mail :to => "#{user.email}", :subject => "[BEM] Registration Confirmation for #{user.name}",
         :from => SUPPORT,
         :bcc => BCC_LIST << ACCOUNTS,
         :reply_to => ACCOUNTS
  end

  def order_confirmation(order)
    @order = order
    @user = order.user
    @greeting = "Hi #{@user.name}"

    mail :to => "#{@user.email}", :subject => "[BEM] Order Confirmation Number #{order.id}",
         :from => SUPPORT,
         :bcc => BCC_LIST << ORDERS,
         :reply_to => ORDERS
  end
end
