{
  podinfo: {
    ingress: {
      "apiVersion": "networking.k8s.io/v1beta1",
      "kind": "Ingress",
      "metadata": {
        "name": "podinfo",
        "labels": {"app": "podinfo"},
      },
      "spec": {
        "rules": [
          {
            "host": "podinfo.cygnus.home.ldaws.com",
            "http": {
              "paths": [{
                "path": "",
                "backend": {
                  "serviceName": "podinfo",
                  "servicePort": "http"
                },
              }],
            }
          },
        ],
      },
    },
    service: {
      "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
        "name": "podinfo",
        "labels": {"app": "podinfo"},
      },
      "spec": {
        "type": "ClusterIP",
        "selector": {
          "app": "podinfo"
        },
        "ports": [
          {
            "name": "http",
            "port": 9898,
            "protocol": "TCP",
            "targetPort": "http"
          },
          {
            "port": 9999,
            "targetPort": "grpc",
            "protocol": "TCP",
            "name": "grpc"
          }
        ]
      }
    },
    deployment: {
      "apiVersion": "apps/v1",
      "kind": "Deployment",
      "metadata": {
        "name": "podinfo",
        "labels": {"app": "podinfo"},
      },
      "spec": {
        "minReadySeconds": 3,
        "revisionHistoryLimit": 5,
        "progressDeadlineSeconds": 60,
        "strategy": {
          "rollingUpdate": {
            "maxUnavailable": 0
          },
          "type": "RollingUpdate"
        },
        "selector": {
          "matchLabels": {
            "app": "podinfo"
          }
        },
        "template": {
          "metadata": {
            "annotations": {
              "prometheus.io/scrape": "true",
              "prometheus.io/port": "9797"
            },
            "labels": {
              "app": "podinfo"
            }
          },
          "spec": {
            "containers": [
              {
                "name": "podinfod",
                "image": "stefanprodan/podinfo:4.0.4",
                "imagePullPolicy": "IfNotPresent",
                "ports": [
                  {
                    "name": "http",
                    "containerPort": 9898,
                    "protocol": "TCP"
                  },
                  {
                    "name": "http-metrics",
                    "containerPort": 9797,
                    "protocol": "TCP"
                  },
                  {
                    "name": "grpc",
                    "containerPort": 9999,
                    "protocol": "TCP"
                  }
                ],
                "command": [
                  "./podinfo",
                  "--port=9898",
                  "--port-metrics=9797",
                  "--grpc-port=9999",
                  "--grpc-service-name=podinfo",
                  "--level=info",
                  "--random-delay=false",
                  "--random-error=false"
                ],
                "env": [
                  {
                    "name": "PODINFO_UI_COLOR",
                    "value": "#34577c"
                  }
                ],
                "livenessProbe": {
                  "exec": {
                    "command": [
                      "podcli",
                      "check",
                      "http",
                      "localhost:9898/healthz"
                    ]
                  },
                  "initialDelaySeconds": 5,
                  "timeoutSeconds": 5
                },
                "readinessProbe": {
                  "exec": {
                    "command": [
                      "podcli",
                      "check",
                      "http",
                      "localhost:9898/readyz"
                    ]
                  },
                  "initialDelaySeconds": 5,
                  "timeoutSeconds": 5
                },
                "resources": {
                  "limits": {
                    "cpu": "2000m",
                    "memory": "512Mi"
                  },
                  "requests": {
                    "cpu": "100m",
                    "memory": "64Mi"
                  }
                }
              }
            ]
          }
        }
      }
    }
  }
}
