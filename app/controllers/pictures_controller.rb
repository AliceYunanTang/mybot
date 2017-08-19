class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    if @current_user.is_admin
      @pictures = Picture.order('created_at DESC')
    else
      @pictures = @current_user.pictures.order('created_at DESC')
    end
    # @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  def dragdrop

  end


  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)

    if params[:file].present?
      req = Cloudinary::Uploader.upload params[:file]
      @picture.image = req['public_id']
    end

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end


  def upload


    # Google Cloud Vison authentication on Heroku, if local host, comment below 4 lines 
    Google::Auth::ServiceAccountCredentials.make_creds(
      scope: 'https://www.googleapis.com/auth/drive',
      json_key_io: StringIO.new(ENV['GOOGLE_APPLICATION_CREDENTIALS'])
    )

    # require "google/cloud/vision"
    # Cloudinary upload and save public_id result with Picture.create
    if params[:file].present?

      picture = Picture.create user: @current_user

      tmpfile = params[:file].tempfile.path  # get AJAX-uploaded temp image path

      vision = Google::Cloud::Vision.new
      image = vision.image tmpfile  # give actual temp file to upload to Google; can also provide URL
      annotation = vision.annotate image, faces: true, labels: true

      # return the Vision data AND the picture ID immediately, don't wait for the
      # Cloudinary upload to finish!
      render json: { grpc: annotation.grpc, picture_id: picture.id }


      # after the upload finishes, update the new picture with its Cloudinary ID
      req = Cloudinary::Uploader.upload params[:file]
      picture.update image: req['public_id'], detail: annotation

      # puts picture
    else
      render json: {error: 'No file given'}, status: :unprocessable_entity
    end

  end



  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    if params[:file].present?
      req = Cloudinary::Uploader.upload params[:file]
      @picture.image = req['public_id']
    end
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:title, :image, :detail, :user_id)
    end
end
