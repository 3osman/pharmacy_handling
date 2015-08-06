class PaperController < ApplicationController
 
  def first_step
  end

  def generate_pdf
  	@patient = Patient.find(params[:patient])
    if !params[:from_add]
    	medtable = MedTable.new
    	medtable.patient = @patient
    	medtable.save!
      @medtable_id = medtable.id
    else 
      @medtable_id = params[:medtable_id]
    end
    @patient_id = @patient.id 


  end
  def add_to_medicines
    medTableEntry = MedTableEntry.new
    medTableEntry.med_table_id = params[:medtableid]
    medTableEntry.medicine_id = params[:medid]
    medTableEntry.instruction = params[:instructions]
    medTableEntry.duration = params[:duration]
    medTableEntry.morning = params[:morning]
    medTableEntry.afternoon = params[:afternoon]
    medTableEntry.evening = params[:evening]
    medTableEntry.save!
    #@medtable_id = params[:medtableid]
    @from_add = true
    #@medicines_add.push("dfd")
    redirect_to :action => :generate_pdf, :patient =>  params[:patient], :medtable_id => params[:medtableid], :from_add => @from_add

  end
end

