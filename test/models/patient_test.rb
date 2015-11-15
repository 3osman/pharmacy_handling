require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  
  test "Patient saves with all parameters" do
    patient = Patient.create(name: 'Name', age: 25, phone_number: '34352', first_check_in: '15-12-2015')
    assert patient.valid?, 'The patient was not valid when all parameters were supplied' 
    assert_equal 'Name', patient.name, 'Patient name does not match'
  end

  test "Patient doesn't save without all parameters" do
    patient = Patient.create(age: 25)
    assert_not patient.valid?, 'The patient should not be valid when missing name'
  end

end
