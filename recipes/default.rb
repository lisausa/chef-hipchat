hipchat = chef_gem 'hipchat' do
  action :nothing
end

hipchat.run_action(:install)


include_recipe 'chef_handler'


chef_handler 'HipChat::NotifyRoom' do
  source "#{node['chef_handler']['handler_path']}/hipchat.rb"
  arguments node.hipchat.to_hash.values_at(:api_token, :room)
  action :nothing
  supports exception: true
end.run_action(:enable)