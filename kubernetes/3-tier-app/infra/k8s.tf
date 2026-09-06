resource "kubernetes_namespace" "namespace"{
    metadata {
        name = var.namespace
    }
}

resource "kubernetes_config_map" "configmap"{
    metadata {
        name = "backend-config"
        namespace = kubernetes_namespace.namespace.metadata[0].name
    }
    data ={
        
        DB_HOST=aws_db_instance.rds.address
        DB_PORT=5432
        DB_NAME=aws_db_instance.rds.db_name
        DB_USERNAME=aws_db_instance.rds.username
        ALLOWED_ORIGINS="http://localhost:3000,http://localhost:80"

    }
}

resource "kubernetes_secret" "backendsecret"{
    metadata {
        name = "backend-secret"
        namespace = kubernetes_namespace.namespace.metadata[0].name
    }
    data = {
        DATABASE_URL= aws_db_instance.rds.address
        DB_PASSWORD=aws_secretsmanager_secret_version.rds_secret_version.secret_string
        
    }

    type = "Opaque"
}

resource "kubernetes_service" "backendservice" {
    metadata {
        name = "backend-service"
        namespace = kubernetes_namespace.namespace.metadata[0].name
    }
    spec {
        selector = {
            app = "backend"
        }
  
    port {
        port = 8000
        target_port = 8000
        protocol = "TCP"

    }
      
    type = "ClusterIP"
}
}

resource "kubernetes_service" "frontendservice"{
    metadata {
        name = "frontend-service"
        namespace = kubernetes_namespace.namespace.metadata[0].name
    }
    spec {
        selector = {
            app = "frontend"
        }
        port {
            port = 80
            target_port = 80
            protocol = "TCP"
        }
        type = "ClusterIP"
    }

}

resource "kubernetes_config_map" "frontend_configmap"{
    metadata {
        name = "frontend-config"
        namespace = kubernetes_namespace.namespace.metadata[0].name
    }
    data ={
        
        BACKEND_URL="http://backend-service:8000"

    }

}