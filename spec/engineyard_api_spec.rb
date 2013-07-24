require 'rspec'
require 'webmock/rspec'
require './lib/engineyard-api'
require './spec/json_environment.rb'
require './spec/json_log.rb'

# {"accounts":[{"id":7952,"name":"James-test"}]}

# {"environments":[{"id":38093,"name":"CalTest","ssh_username":"deploy","app_server_stack_name":"nginx_unicorn","framework_env":"production","instance_status":"running","instances_count":2,"load_balancer_ip_address":"50.19.255.142","account":{"id":7952,"name":"James-test"},"stack_name":"nginx_unicorn","instances":[{"id":244191,"status":"running","role":"db_master","name":null,"amazon_id":"i-5e07d53b","public_hostname":"ec2-107-20-5-182.compute-1.amazonaws.com","bridge":false,"availability_zone":"us-east-1b"},{"id":244192,"status":"running","role":"app_master","name":null,"amazon_id":"i-ae69dbc5","public_hostname":"ec2-50-19-255-142.compute-1.amazonaws.com","bridge":true,"availability_zone":"us-east-1b"}],"app_master":{"id":244192,"status":"running","role":"app_master","name":null,"amazon_id":"i-ae69dbc5","public_hostname":"ec2-50-19-255-142.compute-1.amazonaws.com","bridge":true,"availability_zone":"us-east-1b"},"apps":[{"id":24733,"name":"weekendsignupcalendar","repository_uri":"git@github.com:engineyard/Weekend-Signup-Calendar.git","app_type_id":"merb","account":{"id":7952,"name":"James-test"}}],"deployment_configurations":{"weekendsignupcalendar":{"id":46381,"domain_name":"_","uri":"http://ec2-50-19-255-142.compute-1.amazonaws.com","migrate":{"perform":false,"command":null},"name":"weekendsignupcalendar","repository_uri":"git@github.com:engineyard/Weekend-Signup-Calendar.git"}}},{"id":54781,"name":"Test1","ssh_username":"deploy","app_server_stack_name":"nginx_passenger3","framework_env":"production","instance_status":"none","instances_count":0,"load_balancer_ip_address":null,"account":{"id":7952,"name":"James-test"},"stack_name":"nginx_passenger3","instances":[],"app_master":null,"apps":[{"id":24733,"name":"weekendsignupcalendar","repository_uri":"git@github.com:engineyard/Weekend-Signup-Calendar.git","app_type_id":"merb","account":{"id":7952,"name":"James-test"}}],"deployment_configurations":{"weekendsignupcalendar":{"id":64389,"domain_name":"_","uri":null,"migrate":{"perform":true,"command":"rake db:migrate"},"name":"weekendsignupcalendar","repository_uri":"git@github.com:engineyard/Weekend-Signup-Calendar.git"}}}]}


## Mock API responses 
include WebMock::API
stub_request(:get, "https://cloud.engineyard.com/api/v2/accounts").
  with(:headers => {'X-Ey-Cloud-Token'=>'12121212121212121212121212121212'}).
  to_return(:status => 200, :body => '{"accounts":[{"id":7952,"name":"Test"}]}', :headers => {})

stub_request(:get, "https://cloud.engineyard.com/api/v2/environments").
  with(:headers => {'X-Ey-Cloud-Token'=>'12121212121212121212121212121212'}).
  to_return(:status => 200, :body => ENVIRONMENT_JSON, :headers => {})

stub_request(:get, "https://cloud.engineyard.com/api/v2/apps/24733/environments/38093/deployments/last").
  with(:headers => {'X-Ey-Cloud-Token'=>'12121212121212121212121212121212'}).
  to_return(:status => 200, :body => %q{{"deployment":{"id":1232386,"successful":false,"ref":"HEAD","resolved_ref":"854632cecc9a2c06e4428b93bc038f6d1f6cb08e","commit":"854632cecc9a2c06e4428b93bc038f6d1f6cb08e","migrate":false,"migrate_command":null,"app_deployment_id":46381,"environment_id":38093,"app_id":24733,"user_id":7089,"created_at":"2013-06-11T17:57:22+00:00","finished_at":"2013-06-11T17:57:46+00:00","last_modified_utc":"2013-06-11T17:57:46Z","warnings":"ERROR: Exception during deploy: #<EY::Serverside::RemoteFailure: The following command failed on server [ec2-50-19-255-142.compute-1.amazonaws.com(app_master)]\n\n$ ssh -i /home/deploy/.ssh/internal -o StrictHostKeyChecking=no -o UserKnownHostsFile=/tmp/ey-ss-known-hosts.10096.0 -o PasswordAuthentication=no deploy@ec2-50-19-255-142.compute-1.amazonaws.com 'sh -l -c '\\''LANG=\"en_US.UTF-8\" /engineyard/bin/app_weekendsignupcalendar deploy'\\'\n\nUnicorn Starting, Type: rack interface, App Name: weekendsignupcalendar\n\nI, [2013-06-11T10:57:46.125529 #10487]  INFO -- : unlinking existing socket=/var/run/engineyard/unicorn_weekendsignupcalendar.sock\nI, [2013-06-11T10:57:46.125840 #10487]  INFO -- : listening on addr=/var/run/engineyard/unicorn_weekendsignupcalendar.sock fd=7\nI, [2013-06-11T10:57:46.126213 #10487]  INFO -- : Refreshing Gem list\n\n/usr/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require': cannot load such file -- sinatra (LoadError)\nfrom /usr/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'\nfrom /data/weekendsignupcalendar/current/config.ru:3:in `block in <main>'\nfrom /usr/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:55:in `instance_eval'\nfrom /usr/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:55:in `initialize'\nfrom /data/weekendsignupcalendar/current/config.ru:1:in `new'\nfrom /data/weekendsignupcalendar/current/config.ru:1:in `<main>'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn.rb:44:in `eval'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn.rb:44:in `block in builder'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn/http_server.rb:688:in `call'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn/http_server.rb:688:in `build_app!'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn/http_server.rb:134:in `start'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/bin/unicorn:121:in `<top (required)>'\nfrom /usr/bin/unicorn:19:in `load'\nfrom /usr/bin/unicorn:19:in `<main>'\nThere was a problem starting unicorn displaying log files:\nmaster failed to start, check stderr log for details\n\n>\n/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/servers.rb:113:in `run_on_each'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/servers.rb:67:in `run'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/task.rb:80:in `run'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/deploy.rb:120:in `restart'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/task.rb:73:in `roles'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/deploy.rb:119:in `restart'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/deploy.rb:102:in `send'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/deploy.rb:102:in `run_with_callbacks'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/deploy.rb:47:in `cached_deploy'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/deploy.rb:18:in `deploy'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/cli.rb:34:in `send'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/cli.rb:34:in `deploy'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/cli.rb:135:in `init_and_propagate'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/cli.rb:147:in `init'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/cli.rb:132:in `init_and_propagate'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/engineyard-serverside/cli.rb:33:in `deploy'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/vendor/thor/lib/thor/task.rb:27:in `send'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/vendor/thor/lib/thor/task.rb:27:in `run'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/vendor/thor/lib/thor/invocation.rb:120:in `invoke_task'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/vendor/thor/lib/thor.rb:275:in `dispatch'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/lib/vendor/thor/lib/thor/base.rb:425:in `start'/usr/local/ey_resin/ruby/lib/ruby/gems/1.8/gems/engineyard-serverside-2.1.3/bin/engineyard-serverside:10/usr/local/ey_resin/ruby/bin/engineyard-serverside:19:in `load'/usr/local/ey_resin/ruby/bin/engineyard-serverside:19\n[Relax] Your site is still running old code and nothing destructive has occurred.\nERROR: The following command failed on server [ec2-50-19-255-142.compute-1.amazonaws.com(app_master)]\n\n$ ssh -i /home/deploy/.ssh/internal -o StrictHostKeyChecking=no -o UserKnownHostsFile=/tmp/ey-ss-known-hosts.10096.0 -o PasswordAuthentication=no deploy@ec2-50-19-255-142.compute-1.amazonaws.com 'sh -l -c '\\''LANG=\"en_US.UTF-8\" /engineyard/bin/app_weekendsignupcalendar deploy'\\'\n\nUnicorn Starting, Type: rack interface, App Name: weekendsignupcalendar\n\nI, [2013-06-11T10:57:46.125529 #10487]  INFO -- : unlinking existing socket=/var/run/engineyard/unicorn_weekendsignupcalendar.sock\nI, [2013-06-11T10:57:46.125840 #10487]  INFO -- : listening on addr=/var/run/engineyard/unicorn_weekendsignupcalendar.sock fd=7\nI, [2013-06-11T10:57:46.126213 #10487]  INFO -- : Refreshing Gem list\n\n/usr/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require': cannot load such file -- sinatra (LoadError)\nfrom /usr/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'\nfrom /data/weekendsignupcalendar/current/config.ru:3:in `block in <main>'\nfrom /usr/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:55:in `instance_eval'\nfrom /usr/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:55:in `initialize'\nfrom /data/weekendsignupcalendar/current/config.ru:1:in `new'\nfrom /data/weekendsignupcalendar/current/config.ru:1:in `<main>'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn.rb:44:in `eval'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn.rb:44:in `block in builder'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn/http_server.rb:688:in `call'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn/http_server.rb:688:in `build_app!'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/lib/unicorn/http_server.rb:134:in `start'\nfrom /usr/lib/ruby/gems/1.9.1/gems/unicorn-4.1.1/bin/unicorn:121:in `<top (required)>'\nfrom /usr/bin/unicorn:19:in `load'\nfrom /usr/bin/unicorn:19:in `<main>'\nThere was a problem starting unicorn displaying log files:\nmaster failed to start, check stderr log for details","user_name":"James Joseph Paterni","origin":"web","is_finished":true,"log_uri":"/apps/24733/environments/38093/deployments/1232386","pretty_log_uri":"/apps/24733/environments/38093/deployments/1232386/pretty","app_deployment":{"id":46381,"domain_name":"_","uri":"http://ec2-50-19-255-142.compute-1.amazonaws.com","migrate":{"perform":false,"command":null},"name":"weekendsignupcalendar","repository_uri":"git@github.com:engineyard/Weekend-Signup-Calendar.git"},"resource_uri":"/api/v2/apps/24733/environments/38093/deployments/1232386"}}}, :headers => {})

stub_request(:get, "https://cloud.engineyard.com/api/v2/apps/24733/environments/54781/deployments/last").
     with(:headers => {'X-Ey-Cloud-Token'=>'12121212121212121212121212121212'}).
     to_return(:status => 200, :body => %q{{}}, :headers => {})

stub_request(:get, /https:\/\/cloud.engineyard.com\/api\/v2\/instances\/[0-9]+\/logs/).
  with(:headers => {'X-Ey-Cloud-Token'=>'12121212121212121212121212121212'}).
  to_return(:status => 200, :body => JSON_LOG, :headers => {})
  
  stub_request(:get, /https:\/\/cloud.engineyard.com\/api\/v2\/instances\/[0-9]+\/alerts/).
  with(:headers => {'X-Ey-Cloud-Token'=>'12121212121212121212121212121212'}).
  to_return(:status => 200, :body => JSON_LOG, :headers => {})

ey = EngineyardAPI.new(:key => '12121212121212121212121212121212')

describe EngineyardAPI::Engineyard do
  it "should have one or more accounts" do
    ey.accounts.count > 0
  end
end

describe EngineyardAPI::Account do
  before do
    @account = ey.accounts[0]
  end
  
  it "Should have a name" do
    @account.name === String
  end
  
  it "Should have an id" do
    @account.id === Integer
  end
  
  it "Should have at least one environment" do
    @account.environments.count > 0
  end  
end

describe EngineyardAPI::Environment do
  before do
    @environment = ey.accounts[0].environments.first
  end
  
  it "should have an id" do
    @environment.environment_id === Integer
  end
  
  it "should have a name" do
    @environment.name === String
  end
  
  it "should have an instance_count greater then 0" do
    @environment.instance_count > 0
  end
  
  it "instance_count should equal instances.count" do
    @environment.instance_count == @environment.instances.count 
  end
  
  it "should respond to load_balancer_ip_address" do
    @environment.respond_to? :load_balancer_ip_address
  end
  it 'should respond to stack_name' do
    @environment.respond_to? :stack_name
  end

  it 'should respond to ssh_username' do
    @environment.respond_to? :ssh_username
  end

  it 'should respond to app_server_stack_name' do
    @environment.respond_to? :app_server_stack_name
  end

  it 'should respond to framework_env' do
    @environment.respond_to? :framework_env
  end

  it 'should respond to deployment_configurations' do
    @environment.respond_to? :deployment_configurations
  end

  it 'should respond to app_master' do
    @environment.respond_to? :app_master
  end

  it 'should respond to add_instance' do
    @environment.respond_to? :add_instance
  end

  it 'should respond to add_status' do
    @environment.respond_to? :add_status
  end

  it 'should respond to remove_instance' do
    @environment.respond_to? :remove_instance
  end

  it 'should respond to remove_status' do
    @environment.respond_to? :remove_status
  end

  it 'should respond to busy?' do
    @environment.respond_to? :busy?
  end

  it 'should respond to deploying?' do
    @environment.respond_to? :deploying?
  end

  it 'should respond to rebuild' do
    @environment.respond_to? :rebuild
  end

  it 'should respond to reload' do
    @environment.respond_to? :reload
  end
end

describe EngineyardAPI::Instance do
  before do
    @instance = ey.accounts[0].environments.first.instances.first
  end
  it 'should respond to instance_id' do
    @instance.respond_to? :instance_id
  end

  it 'should be running' do
    @instance.status == :running
  end

  it 'role should be string' do
    @instance.role === String
  end

  it 'should respond to name' do
    @instance.respond_to? :name
  end

  it 'amazon_id should be string beginnign with i-' do
    @instance.amazon_id =~ /^i-/
  end

  it 'public_hostname sould be string' do
    @instance.public_hostname === String
  end

  it 'zone should be string' do
    @instance.zone === String
  end
end
