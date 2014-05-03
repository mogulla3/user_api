require 'logger'
require 'sinatra/reloader'
Bundler.require

users  = YAML.load_file('userdata.yml')
logger = Logger.new('logs/user_api.log')
logger.level = Logger::DEBUG

# 単一ユーザー情報の取得
get '/users/:id' do

  # 指定されたidのユーザーを取得する
  # 存在しない場合、detectはnilを返す
  user = users.detect {|user| user['id'] == params[:id].to_i}

  unless user
    logger.info({'status' => 400, 'message' => "user_id '#{params[:id]}' is not found", 'params' => params})
    return json({'status' => 400, 'message' => "user_id '#{params[:id]}' is not found"})
  end

  logger.info({'status' => 200, 'message' => 'success', 'params' => params})
  json(user)

end

# 複数ユーザー情報の取得
get '/users/' do 
  'under construction' 
end

# ユーザー情報の新規作成
post '/users' do
  'under construction'
end

# ユーザー情報の更新
put '/users' do
  'under construction'
end

delete '/users' do
  'under construction'
end
