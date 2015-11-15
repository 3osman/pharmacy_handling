class MedicinesController < ApplicationController
  before_action :set_medicine, only: [:show, :edit, :update, :destroy]

  # GET /medicines
  # GET /medicines.json
  def index
    @medicines = Medicine.all
  end

  # GET /medicines/1
  # GET /medicines/1.json
  def show
  end

  # GET /medicines/new
  def new
    if current_user.try(:admin?)
      @medicine = Medicine.new
    else
      flash[:alert] = 'You are not an Admin'
      redirect_to action: "index"
    end
  end

  # GET /medicines/1/edit
  def edit
    if !current_user.try(:admin?)
      flash[:alert] = 'You are not an Admin'
      redirect_to action: "index"
    end

  end

  # POST /medicines
  # POST /medicines.json
  def create
    @medicine = Medicine.new(medicine_params)
    
    if !@medicine.quantity.nil? && @medicine.quantity>0
      @medicine.availability = true
    else 
      @medicine.availability = false
    end

    respond_to do |format|
      if @medicine.save
        flash[:notice] = 'Medicine was successfully created.'
        format.html { redirect_to action: "index"}
        format.json { render :show, status: :created, location: @medicine }
      else
        format.html { render :new }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicines/1
  # PATCH/PUT /medicines/1.json
  def update
    respond_to do |format|
      if @medicine.update(medicine_params)
        if !@medicine.quantity.nil? && @medicine.quantity>0
          @medicine.availability = true
        else
          @medicine.availability = false
        end
        @medicine.save!

        flash[:notice] = 'Medicine was successfully updated.'
        format.html { redirect_to action: "index"}
        format.json { render :show, status: :ok, location: @medicine }
      else
        format.html { render :edit }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicines/1
  # DELETE /medicines/1.json
  def destroy
     if current_user.try(:admin?)
      @medicine.destroy
      respond_to do |format|
        format.html { redirect_to medicines_url, notice: 'Medicine was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:alert] = 'You are not an Admin'
      redirect_to action: "index"
    end
    
    
  end

  def new_file
    
  end

  def parse_file
    errors_m = Array.new
    bef = Medicine.count
    require 'spreadsheet'
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet.open File.join(Rails.root, "app/assets/files/excel.xls")
    total = 0
    book.worksheets.each do |sheet|
      
      category = sheet.name
      sheet.each 1 do |row|
          begin
          total += 1
          m = Medicine.new
          m.usage = row[0]
          m.m_type = row[5]
          m.name = row[3]
          m.category = category
          m.save!
            
        
          rescue Exception => e
        #puts m.name
            #er = "Error in sheet #{category}, row #{k}, medicine #{m.name}: doesn't follow format or duplicated"
            #errors_m.push er
          end
         
      end
    end
    after = Medicine.count
    added = after - bef
    not_added = total - added
    
    return " #{added}, #{not_added}"
  end
  def upload
    if !params[:file].nil?
      name = "excel.xls"
      directory = "app/assets/files"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:file].read) }
      total = parse_file
      added = total.split(",")[0]
      no = total.split(",")[1]
      flash[:notice] = "File uploaded, #{added} medicines saved, #{no} not saved."
      redirect_to upload_file_path

    else
      flash[:alert] = 'No file selected'
      redirect_to action: "new_file" 
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medicine_params
      params.require(:medicine).permit(:name, :availability, :quantity, :usage, :side_effects)
    end
end
