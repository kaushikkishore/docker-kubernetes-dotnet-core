FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "WebAPI.dll"]

# To build the image run the below command in docker. 
# docker build -t webapi .

# To run your application run below command now you can access your application on 80 port. 
# docker run -d -p 80:80 --name myapp aspnetapp
# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <containe_name/ID>

# Kubernetes Deployment 

# kubectl run --image <image_name>

# kubectl apply -f .\01.yaml

# kind 
# apiVersion 
# metadata:
#    name: 
# spec:
#    container 



