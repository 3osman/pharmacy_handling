require 'test_helper'

class MedTableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Medtable saves with all parameters" do
    med = MedTable.create(patient_id: 1, template_id: 2, printed: true)
    assert med.valid?, 'The med was not valid when all parameters were supplied' 
    assert_equal 1, med.patient_id, 'MedTable patient_id does not match'
    assert_equal 2, med.template_id, 'MedTable template_id does not match'
  end
  test "Medtable from_template is false by default" do
    med = MedTable.create(patient_id: 1, template_id: 2, printed: true)
    assert med.valid?, 'The med was not valid when all parameters were supplied' 
    assert_equal false, med.from_template, 'MedTable from_template is not false by default'
  end
end
