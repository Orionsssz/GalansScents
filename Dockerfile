
# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar el resto de archivos y compilar
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Exponer puerto 80
EXPOSE 80

# Iniciar la aplicación
ENTRYPOINT ["dotnet", "Perfumeria.dll"]
