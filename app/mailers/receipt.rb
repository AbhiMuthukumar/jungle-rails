class Receipt < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(to_email, order)
    @order = order
    @email_address = to_email
    mail(to: @email_address, subject: "Order ID - #{order.id} has been successfully palced!")
  end
end
