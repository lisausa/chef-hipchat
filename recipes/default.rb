hipchat = chef_gem 'hipchat' do
  action :nothing
end
hipchat.run_action(:install)

# include_recipe 'chef_handler'
# chef_handler 'HipChat::ChefUpdatedResources' do
#   source "#{node['chef_handler']['handler_path']}/hipchat.rb"
#   arguments [config['api_token'], config['room']]
#   action :nothing
#   supports exception: false, report: true
# end.run_action(:enable)
# file "#{node['chef_handler']['handler_path']}/hipchat.rb" do
#   action :delete
# end

node.default[:chef_client][:load_gems][:hipchat] = Mash.new(require_name: 'hipchat/chef')

if config = search(:hipchat, "id:#{node.chef_environment}").first || data_bag_item('hipchat','default')
  node.default[:hipchat][:api_token] = config['api_token']
  node.default[:hipchat][:room]      = config['room']
end

config = node.hipchat

if config[:api_token] and config[:room]
  node.default[:chef_client][:exception_handlers] << Mash.new(
    class: 'HipChat::NotifyRoom',
    arguments: [config[:api_token], config[:room], true].map(&:inspect)
  )
end
