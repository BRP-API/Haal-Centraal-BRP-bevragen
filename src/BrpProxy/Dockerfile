#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    TZ=Europe/Amsterdam
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/BrpProxy/BrpProxy.csproj", "src/BrpProxy/"]
RUN dotnet restore "src/BrpProxy/BrpProxy.csproj"
COPY . .
WORKDIR "/src/src/BrpProxy"
RUN dotnet build "BrpProxy.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BrpProxy.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BrpProxy.dll"]