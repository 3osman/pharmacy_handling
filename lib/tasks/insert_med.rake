namespace :db do

	desc "Populate"
	task :populatemed => :environment do
  		require 'spreadsheet'
		Spreadsheet.client_encoding = 'UTF-8'
		book = Spreadsheet.open File.join(Rails.root, "app/assets/files/excel.xls")

		for i in 0..13
			sheet = book.worksheet i
			category = sheet.name
			k = 0
			sheet.each 1 do |row|
			    k += 1
			    begin
				  m = Medicine.new
				  m.usage = row[0]
				  m.m_type = row[5]
				  m.name = row[3]
				  m.category = category
				  m.save!
			    rescue Exception => e
			  #puts m.name
			  	  puts e
				  puts m.name
				  puts category
				  #puts usage
				  #puts type
				  #puts "++++++++++++++++++++++"
				  puts k
				  puts "++++++++++++++++"
				end
			end
		end
	end
end