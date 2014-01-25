#encoding: utf-8
require 'sinatra/base'
require 'digest/sha1'

class MyApp < Sinatra::Base
  set :sessions, true 
  set :bind, '0.0.0.0'


  configure :production, :development do
    enable :logging
  end

  before do
  	_signature = request[:signature]
  	_timestamp = request[:timestamp]
  	_nonce = request[:nonce]

  	_token = "gh7b8c3f51ceca"

  	_tmpArr = %w[_token, _timestamp, _nonce]

  	_tmpArr.sort!

    _tmpStr = _tmpArr.to_s

		_tmpStr = Digest::SHA1.hexdigest(_tmpStr)  

		headers "Content-Type" => "text/plain;charset=utf-8"

		halt "该请求认证失败！" unless _tmpStr = _signature
  	
  end


  get '/trunk' do
  	
  	_echostr = request[:echostr]
 	 
	end



	post "/trunk" do

		_xmlIo = request.body

		_xmlIo.rewind

	 _xmlStr = _xmlIo.read.force_encoding("utf-8") 

		logger.info "post参数 => #{_xmlStr}"
		 
		_xmlStr = "<xml>
<ToUserName><![CDATA[oUBHXt0bntFcwldJl523BB0o_K4g]]></ToUserName>
<FromUserName><![CDATA[gh_7b8c3f51ceca]]></FromUserName>
<CreateTime>12345678</CreateTime>
<MsgType><![CDATA[text]]></MsgType>
<Content><![CDATA[你好]]></Content>
</xml>"
		
	end

   run! if app_file == $0
end