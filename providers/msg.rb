action :speak do
  require 'hipchat'
  begin
    token    = @new_resource.token    || node[:hipchat][:api_token]
    room     = @new_resource.room     || node[:hipchat][:room]
    nickname = @new_resource.nickname || node[:hipchat][:nickname]

    client = HipChat::Client.new(token)

    message = @new_resource.message || @new_resource.name

    client[room].send(nickname,
                      message,
                      :notify => @new_resource.notify,
                      :color => @new_resource.color)

  rescue => e
      if @new_resource.failure_ok
        Chef::Log.info("HipChat: failed to connect to HipChat.")
        Chef::Log.debug("HipChat: #{e.inspect}")
      else
        Chef::Log.fatal("HipChat: failed to connect to HipChat.")
        Chef::Log.fatal("HipChat: #{e.inspect}")
        raise
      end
  end
end
