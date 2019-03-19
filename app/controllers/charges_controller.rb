class ChargesController < ApplicationController
  def index
    @tenants = Tenant.where(payment_status_id: 2)
  end

  def create
    stripe_customer_id = params[:stripe_customer_id]
    @tenant = Tenant.find(params[:tenant_id])

    charge = Stripe::Charge.create({
    amount: 9900,
    currency: 'eur',
    customer: stripe_customer_id,
    })
    if charge.save 
      flash[:success] = "L'utilisateur a bien été débitée !"
      @tenant.update_attributes(payment_status_id: 3)
      redirect_to root_path
    else
      flash[:danger] = "Erreur, réessayer"
      redirect_to root_path
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charge_index_path
  end
end
