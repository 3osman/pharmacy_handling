class UsersController < ApplicationController
    before_action :check_admin

    def check_admin
        if !current_user.try(:admin?)
            redirect_to :root
        end
    end

    def index
        @users = User.all
    end

    def show
      @user = User.find_by_id(params[:id])
    end

    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_admin_index_path, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
    end
   
    def update
        @user = User.find(params[:id])
        if (!@user.username.eql?"") && @user.update_attributes(user_params)
            if params[:admin].eql?"on"
                @user.admin = true
            else
                @user.admin = false
            end
            redirect_to users_admin_index_path, notice: "Updated User."
        else
            render :edit, notice: "Problem Occured"
        end
    end

    def create
        @user = User.new(user_params)
        if params[:admin].eql?"on"
            @user.admin = true
        end
        
        if @user.save
            redirect_to users_admin_index_path, notice: "User succesfully created!" 
        else
            render :new, notice: "Problem Occured"
        end
    end






	private

	def user_params
	  params.require(:user).permit(:username, :password, :admin, :password_confirmation)
	end

end
