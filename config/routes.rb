AngularTodo::Application.routes.draw do
  root "todo#index"
  get "/task_lists" => "todo#index"

  namespace :api, defaults: {format: :json} do
    resources :task_lists, only: [:index, :create]
  end

  get '/templates/:path' => 'templates#template', :constraints => { :path => /.+/  }
end
