require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
  setup do
    @user = FactoryGirl.create :admin
    sign_in @user
    @template = templates(:one)
    @med_table = med_tables(:one)
    @template.med_table = @med_table
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create template" do
    assert_difference('Template.count') do
      post :create, medtableid: @template.med_table.id ,template: { duration: @template.duration, name: @template.name, symptoms: @template.symptoms }
    end

    assert_redirected_to template_path(assigns(:template))
  end

  test "should show template" do
    get :show, id: @template
    assert_response :success
  end

  #test "should get edit" do
    
   # get :edit, id: @template 
   # assert_response :success
  #end

  test "should update template" do
    patch :update, id: @template, template: { duration: @template.duration, name: @template.name, symptoms: @template.symptoms }
    assert_redirected_to template_path(assigns(:template))
  end

  test "should destroy template" do
    assert_difference('Template.count', -1) do
      delete :destroy, id: @template
    end

    assert_redirected_to templates_path
  end
end
