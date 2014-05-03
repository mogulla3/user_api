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
    logger.info({'status' => 400, 'message' => "User-id `#{params[:id]}` is not found.", 'params' => params})
    return json({'status' => 400, 'message' => "User-id `#{params[:id]}` is not found."})
  end

  if params[:fields]

    fields = params[:fields].split(',')
    logger.debug user
    logger.debug fields

    # 存在しないfieldが指定された場合、エラーを返す
    fields.each do |field|
      if user.has_key?(field) == false
        logger.info({'status' => 400, 'message' => "Fields `#{field}` is invalid field.", 'params' => params})
        return json({'status' => 400, 'message' => "Fields `#{field}` is invalid field."})
      end
    end

    return json(user.select {|key| fields.include? key})

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
