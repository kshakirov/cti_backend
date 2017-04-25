class SuperUser < Sinatra::Base

  use JwtAuth
  register Sinatra::ConfigFile
  helpers Sinatra::Cookies
  config_file '../../config/config.yaml'


  configure do
    set :userController, TurboCassandra::Controller::User.new
    set :authNodeController, TurboCassandra::Controller::AuthenticationNode.new
  end


  set(:clearance) { |value|
    condition {
      scopes, customer = request.env.values_at :scopes, :customer
      if customer['id'] == 487
        true
      else
        false
      end
    }
  }


  before do
    content_type :json
  end

  get '/user/', :clearance => true do
    settings.userController.get_users_list
  end

  get '/user/:login' do
    settings.userController.get_user params
  end

  post '/user/' do
    settings.userController.create_user request.body.read
  end

  delete '/user/:login' do
    settings.userController.delete_user params
  end

  get '/authentication_node/', :clearance  => true do
    settings.authNodeController.all
  end

  post '/authentication_node/', :clearance => true  do
    settings.authNodeController.add_node request.body.read
  end

  get '/authentication_node/:name', :clearance => true do
    settings.authNodeController.get_node params
  end
  delete '/authentication_node/:name', :clearance => true do
    settings.authNodeController.delete params
  end


  not_found do
    403
  end


  after do
    response.body = JSON.dump(response.body)
  end

end