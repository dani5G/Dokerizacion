# Guía rápida Docker

## dockerizacion por el nombre de tu imagen
## poner en inventario cualquier

## Build
```bash
docker build -t danielaag5/dockerizacion:v1 .
```

## Correr
```bash
docker run -d --name inventario -p 8080:80 -v inventario_data:/app/data danielaag5/dockerizacion:v1
```

## Push
```bash
docker login
docker push danielaag5/dockerizacion:v1
```

## Verificar que funciona
```bash
curl http://localhost:8080/health
curl http://localhost:8080/productos
```

## Crear un producto
```bash
curl -X POST http://localhost:8080/productos -H "Content-Type: application/json" -d "{\"nombre\":\"Laptop\",\"precio\":999.99,\"stock\":10}"
```

## Probar persistencia
```bash
docker stop inventario
docker start inventario
curl http://localhost:8080/productos
```

## Descargar desde Docker Hub (como tercero)
```bash
docker run -d --name inventario -p 8080:80 -v inventario_data:/app/data danielaag5/dockerizacion:v1
```

# Eliminar contenedor e imagen local
docker stop inventario
docker rm inventario
docker rmi danielaag5/dockerizacion:v1

# Descargar y correr directo desde Docker Hub
docker run -d --name inventario -p 8080:80 -v inventario_data:/app/data danielaag5/dockerizacion:v1