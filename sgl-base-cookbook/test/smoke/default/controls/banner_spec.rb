# test/smoke/default/controls/banner_spec.rb

# Check if /etc/motd exists
describe file('/etc/motd') do
  it { should exist }
end

# Check if /etc/motd contains a specific banner message
describe file('/etc/motd') do
  its('content') { should match /All access to and activities on this system are logged/ }
end
