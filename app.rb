require 'logger'
require 'sinatra/reloader'
Bundler.require

USERS  = YAML.load_file('userdata.yml')
logger = Logger.new('logs/user_api.log')
logger.level = Logger::DEBUG

# 単一ユーザー情報の取得
get '/users/:id' do

  # 指定されたidのユーザーを取得する
  # 存在しない場合、detectはnilを返す
  user = USERS.detect {|user| user['id'] == params[:id].to_i}

  unless user
    logger.info({error_code: 'u-100', status_code: 400, message: "User-id `#{params[:id]}` is invalid.", params: params})
    status 400
    return json({error_code: 'u-100', status_code: 400, message: "User-id `#{params[:id]}` is invalid."})
  end

  if params[:fields]
    fields = params[:fields].split(',')

    status 200
    logger.info({status_code: 200, message: 'success', params: params})
    return json(user.select {|key| fields.include? key})
  end

  logger.info({status_code: 200, message: 'success', params: params})
  status 200
  json(user)

end

# 複数ユーザー情報の取得
# TODO: ログにリクエスト時のURL残したい
get '/users' do

  # id指定がされている場合、該当するidのみを抽出する
  if params[:id]
    userid_list = params[:id].split(',')
    users = USERS.select {|user| userid_list.include?(user['id'].to_s)}
  end

  if params[:fields]
    fields = params[:fields].split(',')

    status 200
    logger.info({status_code: 200, message: 'success', params: params})
    return json(users.map {|user| user.select {|key,_| fields.include? key}})
  end

  logger.info({status_code: 200, message: 'success', params: params})
  status 200
  json(users)

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
