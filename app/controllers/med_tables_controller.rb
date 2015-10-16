class MedTablesController < ApplicationController
  def view
  	@med_tables = Array.new
    @med_table_entries = Hash.new
  	MedTable.where(patient_id: params[:patient_id]).find_each do |entry|
  		@med_tables.push entry
      @med_table_entries["#{entry.id}"] = MedTableEntry.where(med_table_id: entry.id).to_a
  	end
  	@patient_id = params[:patient_id]
  end
  def delete
  	@med_table = MedTable.find(params[:m_id])
  	@med_table.destroy
  	redirect_to :action => :view, :patient_id =>  params[:patient_id]
  end
  def delete_all
  	MedTable.where(patient_id: params[:patient_id]).destroy_all
  	redirect_to :action => :view, :patient_id =>  params[:patient_id]

  end
  def show_history

    @date = MedTable.find(params[:medtableid]).pre_date
    @medTableEntries = MedTableEntry.where(med_table_id:params[:medtableid]).to_a
    @patient =  Patient.find(params[:patient])

    respond_to do |format|
        format.html # show_history.html.erb
        format.js # show_history.js.erb
    end
  end

end
