class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
end


#indexでnilclassになった要因→コントローラーにて、モデル名_controller.rbに記載しないといけないコードをapplication_controllerに書いていた %>
#もう一つアクセスエラーになったのは、routesのとこでmessage#indexと記載していた。（本来tasks）%>
