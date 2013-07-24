ENVIRONMENT_JSON=%q{
{
	"environments": [
		{
			"id": 38093,
			"name": "Environment",
			"ssh_username": "deploy",
			"app_server_stack_name": "nginx_unicorn",
			"framework_env": "production",
			"instance_status": "running",
			"instances_count": 2,
			"load_balancer_ip_address": "127.1.0.142",
			"account": {
				"id": 7952,
				"name": "James-test"
			},
			"stack_name": "nginx_unicorn",
			"instances": [
				{
					"id": 244191,
					"status": "running",
					"role": "db_master",
					"name": null,
					"amazon_id": "i-5e07d53b",
					"public_hostname": "ec2-107-20-5-182.compute-1.amazonaws.com",
					"bridge": false,
					"availability_zone": "us-east-1b"
				},
				{
					"id": 244192,
					"status": "running",
					"role": "app_master",
					"name": null,
					"amazon_id": "i-ae69dbc5",
					"public_hostname": "ec2-127-1-0-142.compute-1.amazonaws.com",
					"bridge": true,
					"availability_zone": "us-east-1b"
				}
			],
			"app_master": {
				"id": 244192,
				"status": "running",
				"role": "app_master",
				"name": null,
				"amazon_id": "i-ae69dbc5",
				"public_hostname": "ec2-127-1-0-142.compute-1.amazonaws.com",
				"bridge": true,
				"availability_zone": "us-east-1b"
			},
			"apps": [
				{
					"id": 24733,
					"name": "Application",
					"repository_uri": "git@github.com:example/Application.git",
					"app_type_id": "merb",
					"account": {
						"id": 7952,
						"name": "James-test"
					}
				}
			],
			"deployment_configurations": {
				"Application": {
					"id": 46381,
					"domain_name": "_",
					"uri": "http://ec2-127-1-0-142.compute-1.amazonaws.com",
					"migrate": {
						"perform": false,
						"command": null
					},
					"name": "Application",
					"repository_uri": "git@github.com:example/Application.git"
				}
			}
		},
		{
			"id": 54781,
			"name": "Test1",
			"ssh_username": "deploy",
			"app_server_stack_name": "nginx_passenger3",
			"framework_env": "production",
			"instance_status": "none",
			"instances_count": 0,
			"load_balancer_ip_address": null,
			"account": {
				"id": 7952,
				"name": "James-test"
			},
			"stack_name": "nginx_passenger3",
			"instances": [],
			"app_master": null,
			"apps": [
				{
					"id": 24733,
					"name": "Application",
					"repository_uri": "git@github.com:example/Application.git",
					"app_type_id": "merb",
					"account": {
						"id": 7952,
						"name": "James-test"
					}
				}
			],
			"deployment_configurations": {
				"Application": {
					"id": 64389,
					"domain_name": "_",
					"uri": null,
					"migrate": {
						"perform": true,
						"command": "rake db:migrate"
					},
					"name": "Application",
					"repository_uri": "git@github.com:example/Application.git"
				}
			}
		}
	]
}
}
