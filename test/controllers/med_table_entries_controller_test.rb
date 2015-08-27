require 'test_helper'

class MedTableEntriesControllerTest < ActionController::TestCase
  setup do
    @med_table_entry = med_table_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:med_table_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create med_table_entry" do
    assert_difference('MedTableEntry.count') do
      post :create, med_table_entry: {  }
    end

    assert_redirected_to med_table_entry_path(assigns(:med_table_entry))
  end

  test "should show med_table_entry" do
    get :show, id: @med_table_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @med_table_entry
    assert_response :success
  end

  test "should update med_table_entry" do
    patch :update, id: @med_table_entry, med_table_entry: {  }
    assert_redirected_to med_table_entry_path(assigns(:med_table_entry))
  end

  test "should destroy med_table_entry" do
    assert_difference('MedTableEntry.count', -1) do
      delete :destroy, id: @med_table_entry
    end

    assert_redirected_to med_table_entries_path
  end
end
