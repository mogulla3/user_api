Bundler.require

users  = YAML.load_file('userdata.yml')
logger = Logger.new('logs/user_api.log')
logger.level = Logger::DEBUG

# 単一ユーザー情報の取得
get '/users/:id' do

  # validator = Validator.new('GET_USER')

  user = users.detect {|user| user['id'] == params[:id].to_i}
  logger.debug user

  # 入力値の取得
  # 随時エラーとロギング

  # バリデーション

  # 要求された処理を実行

  # レスポンスを返す
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
