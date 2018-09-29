class Admin::UsersController < Admin::BaseController
  def index
    @ransack = User.ransack(params[:q])
    @users = @ransack.result(distinct: true).page(params[:page]).per(20)
  end

  def update
    @user = User.find(params[:id])
    if @user.email == "admin@example.com"
      flash[:alert] = "網站管理者權限無法修改"
      redirect_to admin_users_path
    else
      @user.update(role: params[:role])
      flash[:notice] = "#{@user.name}權限更新為#{params[:role]}"
      redirect_to admin_users_path
    end
  end
end
