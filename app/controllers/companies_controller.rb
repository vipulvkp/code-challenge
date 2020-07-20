class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_updates

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      render :edit
    end
  end  

  def destroy
     message = "Deleted"
     begin 
       c = Company.find(params[:id]) 
       c.destroy 
     rescue
       message = "Some error occured while deleting this company" 
     end
     redirect_to companies_path, notice: message
  end
  

  private

  def handle_invalid_updates(err)
    p "coming in handle invalid updates"
    p err
    render :edit
  end

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end
  
end
