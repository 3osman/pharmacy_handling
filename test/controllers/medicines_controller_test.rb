require 'test_helper'

class MedicinesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
  
  setup do 
    @user = FactoryGirl.create :admin
    sign_in @user
    @medicine = medicines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medicines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medicine" do
    assert_difference('Medicine.count') do
      post :create, medicine: { availability: @medicine.availability, name: @medicine.name, quantity: @medicine.quantity, side_effects: @medicine.side_effects, usage: @medicine.usage }
    end

    assert_redirected_to medicines_path
  
  end

  test "should show medicine" do
    get :show, id: @medicine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @medicine
    assert_response :success
  end

  test "should update medicine" do
    patch :update, id: @medicine, medicine: { availability: @medicine.availability, name: @medicine.name, quantity: @medicine.quantity, side_effects: @medicine.side_effects, usage: @medicine.usage }
    assert_redirected_to medicines_path
  end
  

  test "should destroy medicine" do
    assert_difference('Medicine.count', -1) do
      delete :destroy, id: @medicine
    end

    assert_redirected_to medicines_path
  end
end
