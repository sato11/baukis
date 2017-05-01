class Staff::CustomersController < Staff::Base
  before_action :set_customer_form, only: %i(new create)
  before_action :set_customer_form_with_params, only: %i(edit update)

  def index
    @customers = Customer.order(:family_name_kana, :given_name_kana).page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new; end

  def create
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = '顧客を追加しました。'
      redirect_to action: 'index'
    else
      flash.alert = '入力に誤りがあります。'
      render action: 'new'
    end
  end

  def edit; end

  def update
    @customer_form.assign_attributes(params[:form])
    if @customer_form.save
      flash.notice = '顧客を更新しました。'
      redirect_to action: 'index'
    else
      flash.alert = '入力に誤りがあります。'
      render action: 'edit'
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = '顧客アカウントを削除しました。'
    redirect_to :staff_customers
  end

  private

  def set_customer_form
    @customer_form = Staff::CustomerForm.new
  end

  def set_customer_form_with_params
    @customer_form = Staff::CustomerForm.new(Customer.find(params[:id]))
  end
end
