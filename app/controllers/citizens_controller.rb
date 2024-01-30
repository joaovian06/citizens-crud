class CitizensController < ApplicationController
  before_action :set_citizen, only: %i[ show edit update destroy ]

  # GET /citizens or /citizens.json
  def index
    @citizens = Citizen.all
  end

  # GET /citizens/1 or /citizens/1.json
  def show
  end

  # GET /citizens/new
  def new
    @citizen = Citizen.new
  end

  # GET /citizens/1/edit
  def edit
  end

  # POST /citizens or /citizens.json
  def create
    @citizen = Citizen.new(citizen_params)

    respond_to do |format|
      if @citizen.save
        format.html do
          redirect_to citizen_url(@citizen), success: t(".created")
          flash[:success] = t(".success")
        end

        format.json { render :show, status: :created, location: @citizen }
      else
        format.html do
          flash.now[:error] = t(".failure")
          render :new, status: :unprocessable_entity
        end
        
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /citizens/1 or /citizens/1.json
  def update
    respond_to do |format|
      if @citizen.update(citizen_params)
        format.html do
          redirect_to citizen_url(@citizen), notice: "Citizen was successfully updated."
          flash[:success] = t(".success")
        end

        format.json { render :show, status: :ok, location: @citizen }
      else
        format.html do
          flash.now[:error] = t(".failure")
          render :edit, status: :unprocessable_entity
        end

        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /citizens/1 or /citizens/1.json
  def destroy
    @citizen.destroy

    respond_to do |format|
      format.html { redirect_to citizens_url, notice: "Citizen was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_citizen
      @citizen = Citizen.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def citizen_params
      params.require(:citizen).permit(
        :full_name, :cpf, :cns, :email, :birthdate, :phone_number, :avatar, :status, 
        addresses_attributes: [:id, :cep, :street, :complement, :district, :city, :uf, :ibge_code]
      )
    end
end
