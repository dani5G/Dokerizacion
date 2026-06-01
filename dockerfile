# Etapa 1: compilar la aplicacion
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Copiamos pom.xml primero para aprovechar cache de dependencias
COPY pom.xml .
RUN mvn dependency:go-offline

# Copiamos el codigo y compilamos
COPY src ./src
RUN mvn package -DskipTests

# Etapa 2: imagen final mas liviana
FROM eclipse-temurin:21-jre

# Instalamos nginx para recibir peticiones y supervisor para manejar los procesos
RUN apt-get update && apt-get install -y nginx supervisor

WORKDIR /app

# Copiamos el jar compilado
COPY --from=builder /app/target/*.jar app.jar

# Copiamos configuraciones
COPY nginx.conf /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Los datos de H2 se guardan aqui para que persistan
VOLUME ["/app/data"]

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]