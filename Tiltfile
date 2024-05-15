load("ext://cert_manager", "deploy_cert_manager")
load("ext://helm_resource", "helm_resource", "helm_repo")

deploy_cert_manager(load_to_kind=True)

helm_repo("helm-repo-redpanda", "https://charts.redpanda.com", labels="kafka")
helm_resource(
    "helm-release-redpanda",
    release_name="redpanda",
    namespace="redpanda",
    chart="helm-repo-redpanda/redpanda",
    flags=["--create-namespace", "-f", "deploy/kubernetes/infra/redpanda/values.yaml"],
    port_forwards=[port_forward(8080, 8080, name="console")],
    labels="kafka",
)

helm_repo("helm-repo-flink-operator", "https://downloads.apache.org/flink/flink-kubernetes-operator-1.8.0/", labels="flink")
helm_resource(
    "helm-release-flink-operator",
    release_name="flink-operator",
    namespace="flink",
    chart="helm-repo-flink-operator/flink-kubernetes-operator",
    flags=["--create-namespace"],
    labels="flink",
)

k8s_yaml(kustomize("deploy/kubernetes/infra/flink"))
k8s_resource(
    objects=["session-cluster:flinkdeployment"],
    new_name="session-cluster",
    resource_deps=["helm-release-flink-operator"],
    port_forwards=[port_forward(8081, 8081, name="ui")],
    labels="flink",
)
k8s_resource(
    "sql-gateway",
    port_forwards=[port_forward(8083, 8083, name="api")],
    labels="flink"
)