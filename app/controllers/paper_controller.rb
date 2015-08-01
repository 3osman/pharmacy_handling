class PaperController < ApplicationController
  def first_step
  end

  def generate_pdf
  	@patient = Patient.find(params[:patient])
  	medtable = MedTable.new
  	medtable.patient = @patient
  	medtable.save!

  end
end
