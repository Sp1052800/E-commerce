class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:sign_in, :signup, :new, :create, :facebook]
  def index 
    @user=User.all
    # authorize! :manage, @sampleforms
  end
  def new 
    @user=User.new
    @user.build_image
  end
  def create
    @user=User.new(list_para)
    if @user.save(validate: false)
      #SendEmailMailer.welcome(@sampleform).deliver_now!
      redirect_to users_path
    else 
      render:new
    end
  end
  def facebook
    user = User.omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to products_path
  end
  def edit
    @user=User.find(params[:id])
  end

  def show
    @user=User.find(params[:id])
  end
  def update
    @user=User.find(params[:id])
    if @user.update(list_para)
      redirect_to users_path
    else
      render:edit
    end 
  end
  def destroy
    @user=User.find_by_id(params[:id])
    if @user.delete
      redirect_to users_path
    end
  end
  def signup
      @user = User.authenticate(params[:mail], params[:password])
      if @user
          session[:user_id] = @user.id
          flash[:notice]="sucesssfully logged in "
          #redirect_to sampleforms_path(@sampleform)
          redirect_to products_path
        else

          flash[:notice]="either email or password is wrong"
          redirect_to sign_in_users_path
      end
  end
  def logout
    session[:user_id] = nil
    redirect_to sign_in_users_path
  end
  private
  def list_para
    params.require(:user).permit!
  end
end
