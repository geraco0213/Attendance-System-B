class UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit,:update,:destroy,:edit_basic_info]
  
  def index
    @users=User.paginate(page:params[:page],per_page:30)
  end
    
  def show
    @first_day=Date.current.beginning_of_month
    @last_day=@first_day.end_of_month
  end
    
  def new
    @user=User.new
  end
  
  
  def create
   @user=User.new(user_params)
   if @user.save
     log_in @user
     flash[:success]='新規作成に成功しました。'
     redirect_to @user 
   else
     render :new
   end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
     flash[:success]="ユーザー情報を編集しました。"
     redirect_to @user
    else
     render :edit
    end
  end
  

  def destroy
    @user.destroy
    flash[:danger]="#{@user.name}を削除しました。"
    redirect_to users_url
  end
  
  
  #以下、基本情報系＃
  def edit_basic_info
  end
  
  
  def update_basic_info
    @users=User.all
      @users.each do |user|
        if user.update_attributes(basic_info_params)
          flash[:success]="全員の基本情報を更新しました。"
        else
          flash[:danger]="更新は失敗しました。<br>" + user.errors.full_messages.join("<br>")
        end
      end
      redirect_to users_url
  end
  
  
  
  
  private
  
    def user_params
      params.require(:user).permit(:name,:email, :password,:password_confirmation, :department)
    end
    
    
    def basic_info_params
      params.require(:user).permit(:basic_time, :work_time)
    end

end


