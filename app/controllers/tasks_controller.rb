class TasksController < ApplicationController
    before_action :require_user_logged_in, only: [:index, :show, :edit, :new]
    before_action :set_task, only: [:update]
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
    
    
    #require_user_logged_inでは、新しく作る系と、一覧表示系をログインしたユーザーしか見れないようにする。
    #correct_userでは、各ユーザーの登録したデータを、他人が参照・編集できないようにする。そのためそれに関わる、show,edit,update,destroyをアクセス制限する
    #before_actionあるからログイン判定する必要ない
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])    
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'タスクが登録されました'
            redirect_to root_url
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = 'タスクが登録できませんでした'
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = 'タスクが更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'タスクは正常に削除されました'
        redirect_to root_url
    end

    private
    def set_task
        @task = Task.find(params[:id])
    end
    
    #strong parameter
    def task_params
        params.require(:task).permit(:status, :content)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
         redirect_to root_url
        end
    end
    
end




#task_params...は入力フォームに入れた内容をフィルターをかけて読み取る
#フィルタリング処理後に残った文字列をTask.new(task_params)で引数として受け取り、それを@taskへ代入してる
#require(:)の中身はモデル名（小文字）を入れる

#indexでnilclassになった要因→コントローラーにて、モデル名_controller.rbに記載しないといけないコードをapplication_controllerに書いていた %>
#もう一つアクセスエラーになったのは、routesのとこでmessage#indexと記載していた。（本来tasks）%>

#@task.update(task_params)の意味、指定のidで取り出したタスクに対して、新たに文字を入力して内容が、
#privateクラスのtask_paramsメソッドでフィルタリングされて残った文字列が引数として@task.update(task_params)に放り込まれ、無事更新に成功すればflash[:success]となる