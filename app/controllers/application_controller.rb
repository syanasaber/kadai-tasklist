class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private 
    def require_user_logged_in
        unless logged_in?
         redirect_to login_url
        end
    end
    
    def ensure_correct_user

  　if @current_user.id !=  params[:id].to_i

    redirect_to login_url

    end
end


#ここでルーターから受け取った指定のアクションに沿ってモデルからデータを取り出す命令を出す