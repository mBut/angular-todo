AngularTodo::Application.routes.draw do
  root "todo#index"

  # Any task_lists routes render page with AngularTodo application
  get "task_lists" => "todo#index"
  get "task_lists*tasks" => "todo#index"

  namespace :api, defaults: {format: :json} do
    resources :task_lists, only: [:index, :create] do
      resources :tasks
    end
  end

  get '/templates/:path' => 'templates#template', :constraints => { :path => /.+/  }
end
