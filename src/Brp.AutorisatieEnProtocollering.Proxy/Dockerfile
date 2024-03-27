#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    TZ=Europe/Amsterdam
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Brp.AutorisatieEnProtocollering.Proxy/Brp.AutorisatieEnProtocollering.Proxy.csproj", "Brp.AutorisatieEnProtocollering.Proxy/"]
RUN dotnet restore "./Brp.AutorisatieEnProtocollering.Proxy/Brp.AutorisatieEnProtocollering.Proxy.csproj"
COPY . .
WORKDIR "/src/Brp.AutorisatieEnProtocollering.Proxy"
RUN dotnet build "./Brp.AutorisatieEnProtocollering.Proxy.csproj" -c "$BUILD_CONFIGURATION" -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./Brp.AutorisatieEnProtocollering.Proxy.csproj" -c "$BUILD_CONFIGURATION" -o /app/publish /p:UseAppHost=false

FROM base AS final

WORKDIR /app
COPY --from=publish /app/publish .

# See https://github.com/Contrast-Security-OSS/agent-operator/blob/master/docs/public/08-tips.md
ENV DOTNET_HOSTBUILDER__RELOADCONFIGONCHANGE=false

ENTRYPOINT ["dotnet", "Brp.AutorisatieEnProtocollering.Proxy.dll"]