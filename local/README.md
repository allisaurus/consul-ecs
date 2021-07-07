# Local testing with `docker-compose`

This directory contains `docker-compose` files which will locally run `consul-ecs` within a container network which includes [Amazon ECS Local Container Endpoints](https://github.com/awslabs/amazon-ecs-local-container-endpoints). 


# Steps to test locally

1. From the root of this repository (parent folder to this dir), run `go build -o ./local`
2. From within this dir, run `docker build -t consul-ecs:test -f Dockerfile.local .`
3. Update the `command` arg in the _docker-compose.yml_ file to the `consul-ecs` subcommand you wish to test.
4. Add any [top-level task metadata response fields](https://github.com/awslabs/amazon-ecs-local-container-endpoints/blob/mainline/local-container-endpoints/config/config.go#L22) you wish to override to the `environment` section of the `ecs-local-endpoints` container in the _docker-compose.override.yml_ file
4. Run `docker-compose up`. You should see terminal output like the following:
```
$~\consul-ecs\local> docker-compose up

// containers + network creation
Creating network "local_credentials_network" with driver "bridge"
Creating local_ecs-local-endpoints_1 ... done
Creating local_app_1                 ... done
Attaching to local_ecs-local-endpoints_1, local_app_1

// info logs from test cmd
app_1                  | 2021-07-07T18:39:28.783Z [INFO]  cluster name determined: cluster=MY_CLUSTER_ARN_OVERRIDE
ecs-local-endpoints_1  | time="2021-07-07T18:39:27Z" level=info msg="ecs-local-container-endpoints 1.3.0 (4fa3c29) ECS Agent 1.27.0 compatible"
ecs-local-endpoints_1  | time="2021-07-07T18:39:27Z" level=info msg=Running...
app_1                  | 2021-07-07T18:39:29.799Z [INFO]  discovered IP: ip=10.0.1.66 out=output.txt
local_app_1 exited with code 0
```

# Debugging

When running `docker-compose up` you may see this error:
```
Creating network "local_credentials_network" with driver "bridge"
ERROR: Pool overlaps with other one on this address space
```
This probably means the docker networks already exist from previous testing. Remove defunct networks with `docker network prune`