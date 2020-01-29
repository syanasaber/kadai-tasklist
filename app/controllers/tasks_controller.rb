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
    
    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:success] = 'タスクが更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'タスクは正常に削除されました'
        redirect_to tasks_url
    end

    private
    
    #strong parameter
    def task_params
        params.require(:task).permit(:content)
    end
end




#task_params...は入力フォームに入れた内容をフィルターをかけて読み取る
#フィルタリング処理後に残った文字列をTask.new(task_params)で引数として受け取り、それを@taskへ代入してる
#require(:)の中身はモデル名（小文字）を入れる

#indexでnilclassになった要因→コントローラーにて、モデル名_controller.rbに記載しないといけないコードをapplication_controllerに書いていた %>
#もう一つアクセスエラーになったのは、routesのとこでmessage#indexと記載していた。（本来tasks）%>

#@task.update(task_params)の意味、指定のidで取り出したタスクに対して、新たに文字を入力して内容が、
#privateクラスのtask_paramsメソッドでフィルタリングされて残った文字列が引数として@task.update(task_params)に放り込まれ、無事更新に成功すればflash[:success]となる