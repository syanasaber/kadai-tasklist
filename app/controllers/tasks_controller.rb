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
    
    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = 'タスクが登録されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが登録できませんでした'
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
end


private

#strong parameter
def task_params
    params.require(:task).permit(:content)
end

#task_params...は入力フォームに入れた内容をフィルターをかけて読み取る
#フィルタリング処理後に残った文字列をTask.new(task_params)で引数として受け取り、それを@taskへ代入してる
#require(:)の中身はモデル名（小文字）を入れる

#indexでnilclassになった要因→コントローラーにて、モデル名_controller.rbに記載しないといけないコードをapplication_controllerに書いていた %>
#もう一つアクセスエラーになったのは、routesのとこでmessage#indexと記載していた。（本来tasks）%>
