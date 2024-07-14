# Cookbook:: sgl-base-cookbook
# Recipe:: knife_status

# Define the handler class
class Motd::KnifeStatus < Chef::Handler
  def report
    # Get the timestamp of the last successful Chef run
    last_successful_run = run_status.success? ? run_status.end_time.to_i : 0

    # Write the last successful run timestamp to a file
    File.write("#{Chef::Config[:file_cache_path]}/last_successful_chef_run", last_successful_run)
  end
end

# Create an instance of the handler and register it
Motd::KnifeStatus.new.run_report_unless_exception
