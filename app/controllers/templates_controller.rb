class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
  end

  # GET /templates/new
  def new
    session[:return_to] = request.referer

    @template = Template.new
    @medtable = MedTable.new
    @medtable.from_template = true
    @medtable.template_id = @template.id
    @from_tem = true

  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)

    @med_table = MedTable.find(params[:medtableid]) #add med table from view page
    @med_table.template = @template
    @med_table.save!
    respond_to do |format|
      if @template.save
        format.html { redirect_to @template, med_id: @med_table.id, notice: 'Template was successfully created, add prescription now' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    @med_id = @template.med_table.id
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to @template, med_id: @med_id, notice: 'Template was successfully updated, update prescription now' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:name, :symptoms, :duration)
    end
end
