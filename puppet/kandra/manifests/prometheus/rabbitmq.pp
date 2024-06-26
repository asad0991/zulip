# @summary Prometheus monitoring of rabbitmq server.  This is done via
# the built-in prometheus plugin which serves on port 15692:
# https://www.rabbitmq.com/prometheus.html
#
class kandra::prometheus::rabbitmq {
  include kandra::prometheus::base

  exec { 'enable rabbitmq-prometheus':
    command => 'rabbitmq-plugins enable rabbitmq_prometheus',
    unless  => 'grep -q rabbitmq_prometheus /etc/rabbitmq/enabled_plugins',
    require => Service['rabbitmq-server'],
  }
  kandra::firewall_allow { 'rabbitmq': port => '15692' }
}
