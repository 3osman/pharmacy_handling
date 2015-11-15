require 'test_helper'

class MedicineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Medicine saves with all parameters" do
    medicine = Medicine.create(name: 'Name', quantity: 25, usage: '34352', side_effects: 'wfsdf')
    assert medicine.valid?, 'The medicine was not valid when all parameters were supplied' 
    assert_equal 'Name', medicine.name, 'Medicine name does not match'
  end

  test "Medicine doesn't save without all parameters" do
    m = Medicine.create( quantity: 25, usage: '34352', side_effects: 'wfsdf')
    assert_not m.valid?, 'The medicine should not be valid when missing name'
  end

  test "Medicine index on name and m_type" do
    m = Medicine.create(name:'test', m_type:'test_type', quantity: 25, usage: '34352', side_effects: 'wfsdf')
    assert m.valid?, 'First medicine not saved'
    assert_raises ActiveRecord::RecordNotUnique do
      med = Medicine.create(name:'test', m_type:'test_type'), 'Should fail, similar index (name and m_type)'
 	end
  end
end
