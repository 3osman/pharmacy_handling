class UsersController < ApplicationController

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

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)

            redirect_to :root, notice: "Updated User."
        else
            render :edit
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to :root, notice: "User succesfully created!" 
        else
            render :new
        end
    end






	private

	def user_params
	  params.require(:user).permit(:username, :password, :admin, :password_confirmation)
	end

end
