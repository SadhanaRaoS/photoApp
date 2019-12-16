class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :publish]
  before_action :authorize_request
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    @photos = @photos.where(user_id: params[:user]) if params[:user]
    if params[:filter] == 'My Photos'
      @photos = @photos.where(user_id: @current_user.id) 
    elsif params[:filter] == 'Draft'
      @photos = @photos.where(status: :draft)
    end
    if ['Desc','Asc'].include? params[:sort]
      @photos = Photo.where(status: :published).order("published_at #{params[:sort].downcase}")
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    set_status(params)  
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    set_status(params) 
    respond_to do |format|
      updated = photo_params ? @photo.update(photo_params) : @photo.save
      if updated
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish 
    respond_to do |format|
    if @photo.publish_photo
      format.html { redirect_to @photo, notice: 'Photo was successfully published.' }
      format.json { render :show, status: :ok, location: @photo }
    else
      format.html { render :edit }
      format.json { render json: @photo.errors, status: :unprocessable_entity }
    end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:caption, :image) if params[:photo].present?
    end

    def set_status(params)
      if params[:commit] == 'Publish'
        @photo.published_at = Time.now
        @photo.status = :published
      else 
        @photo.published_at = nil 
        @photo.status = :draft
      end
    end
end
