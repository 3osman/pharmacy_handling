class PaperController < ApplicationController
 
  def first_step
  end
  def header(pdf)
    #This inserts an image in the pdf file and sets the size of the image
    pdf.image "#{Rails.root}/app/assets/images/d.jpg", width: 530, height: 150
  end
 
  def text_content(pdf)
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = pdf.cursor - 50
 
    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    #bounding_box([0, y_position], :width => 270, :height => 300) do
     # text "Lorem ipsum", size: 15, style: :bold
      #text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum semper placerat. Aenean mattis fringilla risus ut fermentum. Fusce posuere dictum venenatis. Aliquam id tincidunt ante, eu pretium eros. Sed eget risus a nisl aliquet scelerisque sit amet id nisi. Praesent porta molestie ipsum, ac commodo erat hendrerit nec. Nullam interdum ipsum a quam euismod, at consequat libero bibendum. Nam at nulla fermentum, congue lectus ut, pulvinar nisl. Curabitur consectetur quis libero id laoreet. Fusce dictum metus et orci pretium, vel imperdiet est viverra. Morbi vitae libero in tortor mattis commodo. Ut sodales libero erat, at gravida enim rhoncus ut."
    #end
 
    pdf.bounding_box([0, y_position], :width => 500, :height => 80) do
    

      pdf.text @patient.name, size: 15, style: :bold
      pdf.text @date, size: 15, style: :bold
     # text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
    end
 
  end
 
  def table_content(pdf)
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    pdf.table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [100, 100,80,80,80]
    end
    pdf.table rows do
      
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [100, 100,80,80,80]
    end
  end
 
  def product_rows
    [['Name', 'Instructions','Morning','Afternoon','Evening']] 
  end
  def rows
    
      @medicines.map do |product|
        [product.name]
      end + @med_table_entries.map do |md|
        [md.instruction, md.morning, md.afternoon, md.evening]
      end

  end

  def generate_pdf
  	@patient = Patient.find(params[:patient])
    if !params[:from_add]
    	medtable = MedTable.new
    	medtable.patient = @patient
      medtable.printed = false
      medtable.pre_date = Date.today
    	medtable.save!
      @medtable_id = medtable.id
    else 
      @medtable_id = params[:medtable_id]
    end
    @patient_id = @patient.id 


  end
  def editmed

    
    @medTableEntry = MedTableEntry.find(params[:med_table_entry_id])
    @patient_id =  params[:patient]
    @medtable_id = params[:medtableid]
    respond_to do |format|
        format.html # editmed.html.erb
        format.js # editmed.js.erb
    end
  end

  def download_pdf
    @date = params[:date]
    
    @medicines = Array.new
    #@med_table_entries = Array.new
    #@patient = Patient.new
    m = MedTable.find(params[:med_table_id])
    if !(@date.nil?)
      m.pre_date = @date
    end
    m.printed = true
    m.save!
    @med_table_entries = (MedTable.find(params[:med_table_id])).med_table_entries
    @patient = Patient.find(params[:patient])
    @med_table_entries.each do |md|
      @medicines.push(md.medicine)
    end
    respond_to do |format|
      format.html
      format.pdf do
        require 'prawn'
        pdf = Prawn::Document.new(:page_layout => :landscape,:page_size => 'A4')
        
        #pdf.font Rails.root.join('app', 'assets', 'fonts', 'trado.ttf')
        #pdf.text_direction = :rtl
        
        #pdf = ReportPdf.new(@patient, @med_table_entries, @medicines, @date)
        
        #header(pdf)
        text_content(pdf)
        table_content(pdf)

      
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
  end
  def add_to_medicines
    medTableEntry = MedTableEntry.new

    if !params[:fromedit]
      medTableEntry.med_table_id = params[:medtableid]
      medTableEntry.medicine_id = params[:medid]
      flash[:notice] = "Added"
    else
      medTableEntry = MedTableEntry.find(params[:id])
      flash[:notice] = "Edited"
    end
    
    medTableEntry.instruction = params[:instructions]
    medTableEntry.duration = params[:duration]
    medTableEntry.morning = params[:morning]
    medTableEntry.afternoon = params[:afternoon]
    medTableEntry.evening = params[:evening]
    medTableEntry.save!
    #@medtable_id = params[:medtableid]
    #@medicines_add.push("dfd")
    @from_add = true
    fr = params[:from_tem]
    if !(fr.eql?"") && fr
      puts "++++++++++++++++++++++++"
      print fr
      puts "++++++++++++++++++++++++"
      redirect_to :back

    else
      redirect_to :action => :generate_pdf, :patient =>  params[:patient], :medtable_id => params[:medtableid], :from_add => @from_add
    end 
  end
  def add_empty
    medTableEntry = MedTableEntry.new

    medTableEntry.med_table_id = params[:medtableid]
    flash[:notice] = "Added Empty Row"
   
    medTableEntry.save!
    #@medtable_id = params[:medtableid]
    #@medicines_add.push("dfd")
    @from_add = true

    redirect_to :action => :generate_pdf, :patient =>  params[:patient], :medtable_id => params[:medtableid], :from_add => @from_add

  end
  def delete_entry
    MedTableEntry.destroy(params[:med_table_entry_id])
    respond_to do |format|
        flash[:notice] = "Deleted"
        @from_add = true

        format.html { redirect_to :action => :generate_pdf, :patient =>  params[:patient], :medtable_id => params[:medtableid], :from_add => @from_add }
    end
    
  end
  
end

