require "sinatra"
require "tilt/erb"

class Sinatra::Application
  set :root,          Proc.new { File.join(File.dirname(__FILE__), "application") }
  set :views,         Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "public") }

  disable :logging

  get "/" do
    erb :index
  end

  post "/pusher/auth" do
    channel  = Pusher[params[:channel_name]]
    response = channel.authenticate(params[:socket_id], channel_data)

    MultiJson.dump(response)
  end

  protected

  def channel_data
    return unless params[:channel_name] =~ /^presence-/

    { user_id:   params[:socket_id],
      user_info: { name: "Alan Turing" }
    }
  end
end
