class CategorizationsController < ApplicationController
  before_action :set_categorization, only: %i[ show edit update destroy ]

  # GET /categorizations or /categorizations.json
  def index
    @categorizations = Categorization.all
  end

  # GET /categorizations/1 or /categorizations/1.json
  def show
  end

  # GET /categorizations/new
  def new
    @categorization = Categorization.new
  end

  # GET /categorizations/1/edit
  def edit
  end

  # POST /categorizations or /categorizations.json
  def create
    @categorization = Categorization.new(categorization_params)

    respond_to do |format|
      if @categorization.save
        format.html { redirect_to @categorization, notice: "Categorization was successfully created." }
        format.json { render :show, status: :created, location: @categorization }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorizations/1 or /categorizations/1.json
  def update
    respond_to do |format|
      if @categorization.update(categorization_params)
        format.html { redirect_to @categorization, notice: "Categorization was successfully updated." }
        format.json { render :show, status: :ok, location: @categorization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorizations/1 or /categorizations/1.json
  def destroy
    @categorization.destroy!

    respond_to do |format|
      format.html { redirect_to categorizations_path, status: :see_other, notice: "Categorization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categorization
      @categorization = Categorization.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def categorization_params
      params.expect(categorization: [ :category_id, :library_resource_id ])
    end
end
