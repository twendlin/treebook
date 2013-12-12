class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  



  def index
    @statuses = Status.all



respond_to do | format |  
  format.html # index.html.erb
  format.json { render :json => @statuses }
  format.xlsx {
    xlsx_package = Status.to_xlsx :name => "Statuses", :header_style => {:bg_color => "00", 
                                                                                :fg_color => "FF",  
                                                                                :sz => 16, 
                                                                                :alignment => { :horizontal => :center }},
                                                                                :style => {:border => Axlsx::STYLE_THIN_BORDER}

        timestamp = xlsx_package.workbook.styles.add_style :format_code => "MM-DD-YYYY", 
        :border => Axlsx::STYLE_THIN_BORDER
        
        xlsx_package.workbook.worksheets.first.col_style 5, timestamp, :row_offset => 1
        xlsx_package.workbook.worksheets.first.col_style 6, timestamp, :row_offset => 1
    





    begin 
      temp = Tempfile.new("AssetMortality.xlsx") 
      xlsx_package.serialize temp.path
      send_data xlsx_package.to_stream.read, :filename => 'AssetMortality.xlsx', :type=> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ensure
      temp.close 
      temp.unlink
    end





 }   






  end







  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @status }
      else
        format.html { render action: 'new' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:name, :Asset, :Age, :Description)
    end
end
