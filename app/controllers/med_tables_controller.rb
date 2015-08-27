class MedTablesController < ApplicationController
  def view
  	@med_table_entries = Array.new
  	MedTable.where(patient_id: params[:patient_id]).find_each do |entry|
  		@med_table_entries.push entry
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

end
