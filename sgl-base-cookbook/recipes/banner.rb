# Cookbook:: sgl-base-cookbook
# Recipe:: banner

# Create a directory to store handlers if it doesn't exist
directory "#{Chef::Config[:file_cache_path]}/handlers" do
  mode '0755'
  action :create
end

# File to store the last successful run time
last_run_file = "#{Chef::Config[:file_cache_path]}/last_successful_chef_run"

# Read the last run time if the file exists
last_run = if ::File.exist?(last_run_file)
             ::File.read(last_run_file).strip
           else
             'N/A'
           end

# Fetch necessary variables
environment = node.chef_environment
domain = node['domain'] || 'localdomain'
hostname = node['hostname']

# Create the MOTD template
template '/etc/motd' do
  source 'ssh-banner.erb'
  variables(
    environment: environment,
    domain: domain,
    hostname: hostname,
    last_run: last_run
  )
  action :create
end

# Create /etc/issue.net file
cookbook_file '/etc/issue.net' do
  source 'issue.net'
  action :create
end

# Create /etc/issue file
cookbook_file '/etc/issue' do
  source 'issue.net'
  action :create
end

# Store the current time as the last successful Chef run time
ruby_block 'write_last_successful_run' do
  block do
    ::File.write(last_run_file, Time.now.utc.to_s)
  end
  action :run
end
