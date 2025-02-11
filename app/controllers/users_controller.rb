class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: [:index, :destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # # POST /users or /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: "User was successfully created." }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end



    # Only allow a list of trusted parameters through and the create method for the user
    def user_params
      params.require(:user).permit(:name, :surname, :contact_address, :email, :password, :password_confirmation, :role)
    end

    def create
      role_class = params[:user][:role].constantize # Convert role string to class
      @user = role_class.new(user_params.except(:role)) # Create user of the correct type

      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Account created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end
    # Ensure only LibraryPersonnel can manage users
  def authorize_admin
    redirect_to root_path, alert: "Access denied." unless current_user.is_a?(LibraryPersonnel)
  end
end
