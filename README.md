# Consul - Launch, Backup and Restore a cluster in AWS

This is a tutorial on how to launch, backup and restore a fully working Consul cluster in AWS.

The notes are also posted on the [NETBEARS](https://netbears.com/blog/consul-cluster-aws/) company blog. You might want to check the website out for more tutorials like this.

## What is Consul?

[Consul](https://www.consul.io/intro/index.html) is a service mesh solution providing a full featured control plane with service discovery, configuration, and segmentation functionality. Each of these features can be used individually as needed, or they can be used together to build a full service mesh. Consul requires a data plane and supports both a proxy and native integration model. Consul ships with a simple built-in proxy so that everything works out of the box, but also supports 3rd party proxy integrations such as Envoy.

The key features of Consul are:
1. Service Discovery: Clients of Consul can register a service, such as api or mysql, and other clients can use Consul to discover providers of a given service. Using either DNS or HTTP, 
applications can easily find the services they depend upon.
2. Health Checking: Consul clients can provide any number of health checks, either associated with a given service ("is the webserver returning 200 OK"), or with the local node ("is memory utilization below 90%"). This information can be used by an operator to monitor cluster health, and it is used by the service discovery components to route traffic away from unhealthy hosts.
3. KV Store: Applications can make use of Consul's hierarchical key/value store for any number of purposes, including dynamic configuration, feature flagging, coordination, leader election, and more. The simple HTTP API makes it easy to use.
4. Secure Service Communication: Consul can generate and distribute TLS certificates for services to establish mutual TLS connections. Intentions can be used to define which services are allowed to communicate. Service segmentation can be easily managed with intentions that can be changed in real time instead of using complex network topologies and static firewall rules.
5. Multi Datacenter: Consul supports multiple datacenters out of the box. This means users of Consul do not have to worry about building additional layers of abstraction to grow to multiple regions.

Consul is designed to be friendly to both the DevOps community and application developers, making it perfect for modern, elastic infrastructures.

## Deploy the stack

### Run the CloudFormation template in the AWS Console
* Login to the AWS console and browse to the CloudFormation section
* Select the cloudformation-template.yaml file
* Before clicking "Create", make sure that you scroll down and tick the “I acknowledge that AWS CloudFormation might create IAM resources” checkbox
* ...drink coffee...
* Go to the URL in the output section for the environment that you want to access

### Main resources created

* 1 AutoScaling Group
* 1 Elastic Load Balancer
* 1 S3 bucket (for data backup)
* 1 DNS record (for ease of access)

### Autoscaling

The autoscaling groups uses the CpuUtilization alarm to autoscale automatically. Because of this, you wouldn't have to bother making sure that your hosts can sustain the load.

### Monitoring

The stack launches [NodeExporter](https://github.com/prometheus/node_exporter/) (Prometheus exporter for hardware and OS metrics exposed by NIX kernels, written in Go with pluggable metric collectors) on each host inside the cluster.

The stack also includes a custom [StatsdExporter](https://github.com/prometheus/statsd_exporter/) which is used to send Consul-specific metrics into Prometheus.

## Final notes
Need help implementing this?

Feel free to contact us using [this form](https://netbears.com/#contact-form).
