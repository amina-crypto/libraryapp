class LibraryResourcesController < ApplicationController
  before_action :set_library_resource, only: %i[ show edit update destroy ]

  # GET /library_resources or /library_resources.json
  def index
    @library_resources = LibraryResource.all
  end

  # GET /library_resources/1 or /library_resources/1.json
  def show
  end

  # GET /library_resources/new
  def new
    @library_resource = LibraryResource.new
  end

  # GET /library_resources/1/edit
  def edit
  end

  # POST /library_resources or /library_resources.json
  def create
    @library_resource = LibraryResource.new(library_resource_params)

    respond_to do |format|
      if @library_resource.save
        format.html { redirect_to @library_resource, notice: "Library resource was successfully created." }
        format.json { render :show, status: :created, location: @library_resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @library_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /library_resources/1 or /library_resources/1.json
  def update
    respond_to do |format|
      if @library_resource.update(library_resource_params)
        format.html { redirect_to @library_resource, notice: "Library resource was successfully updated." }
        format.json { render :show, status: :ok, location: @library_resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @library_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /library_resources/1 or /library_resources/1.json
  def destroy
    @library_resource.destroy!

    respond_to do |format|
      format.html { redirect_to library_resources_path, status: :see_other, notice: "Library resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library_resource
      @library_resource = LibraryResource.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.

    def library_resource_params
      params.require(:library_resource).permit(:title, :publish_year, :language, :publisher, :description, :type, :author)
    end
end
