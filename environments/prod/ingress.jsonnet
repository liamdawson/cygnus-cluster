{
  ingress: {
    clusterRole: {
      "kind": "ClusterRole",
      "apiVersion": "rbac.authorization.k8s.io/v1",
      "metadata": {
        "name": "traefik-external",
        "labels": {
          "app.kubernetes.io/name": "traefik-external-rbac",
          "app.kubernetes.io/component": "rbac",
          "app.kubernetes.io/part-of": "traefik-external",
          "app.kubernetes.io/managed-by": "tanka",
          "app.kubernetes.io/instance": "traefik-external-swan"
        }
      },
      "rules": [
        {
          "apiGroups": [
            ""
          ],
          "resources": [
            "services",
            "endpoints",
            "secrets"
          ],
          "verbs": [
            "get",
            "list",
            "watch"
          ]
        },
        {
          "apiGroups": [
            "extensions"
          ],
          "resources": [
            "ingresses"
          ],
          "verbs": [
            "get",
            "list",
            "watch"
          ]
        },
        {
          "apiGroups": [
            "extensions"
          ],
          "resources": [
            "ingresses/status"
          ],
          "verbs": [
            "update"
          ]
        },
        {
          "apiGroups": [
            "traefik.containo.us"
          ],
          "resources": [
            "ingressroutes",
            "ingressroutetcps",
            "ingressrouteudps",
            "middlewares",
            "tlsoptions",
            "tlsstores",
            "traefikservices"
          ],
          "verbs": [
            "get",
            "list",
            "watch"
          ]
        }
      ]
    },
  },
  clusterRoleBinding: {
    "kind": "ClusterRoleBinding",
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "metadata": {
      "name": "traefik-external",
      "labels": {
        "app.kubernetes.io/name": "traefik-external-rbac",
        "app.kubernetes.io/component": "rbac",
        "app.kubernetes.io/part-of": "traefik-external",
        "app.kubernetes.io/managed-by": "tanka",
        "app.kubernetes.io/instance": "traefik-external-swan"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "traefik-external"
    },
    "subjects": [
      {
        "kind": "ServiceAccount",
        "name": "traefik-external",
        "namespace": "default"
      }
    ]
  },
  serviceAccount: {
    "kind": "ServiceAccount",
    "apiVersion": "v1",
    "metadata": {
      "name": "traefik-external",
      "labels": {
        "app.kubernetes.io/name": "traefik-external-rbac",
        "app.kubernetes.io/component": "rbac",
        "app.kubernetes.io/part-of": "traefik-external",
        "app.kubernetes.io/managed-by": "tanka",
        "app.kubernetes.io/instance": "traefik-external-swan"
      }
    }
  },
  serviceAccountSecret: {
    "kind": "Secret",
    "apiVersion": "v1",
    "metadata": {
      "name": "traefik-external",
      "labels": {
        "app.kubernetes.io/name": "traefik-external-rbac",
        "app.kubernetes.io/component": "rbac",
        "app.kubernetes.io/part-of": "traefik-external",
        "app.kubernetes.io/managed-by": "tanka",
        "app.kubernetes.io/instance": "traefik-external-swan"
      },
      "annotations": {
          "kubernetes.io/service-account.name": "traefik-external"
      }
    },
    "type": "kubernetes.io/service-account-token"
  }
}
