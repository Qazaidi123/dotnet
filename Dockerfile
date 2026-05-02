FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

#Create folder inside container
WORKDIR /app

#Copy everything into /app into the container
COPY . ./

# Restore dependencies
RUN dotnet restore

#Build and publish the app
RUN dotnet publish -c Release -o out

#Stage2: Runtime Environment
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

#Copy published output from build stage
COPY --from=build-env /app/out ./

# Expose at port 5000
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

#Run the application
ENTRYPOINT ["dotnet","Netapp.dll]

