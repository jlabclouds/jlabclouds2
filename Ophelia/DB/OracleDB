# Oracle
https://learn.microsoft.com/en-us/dotnet/aspire/database/oracle-entity-framework-integration?tabs=package-reference

dotnet new install Aspire.ProjectTemplates
dotnet new aspire-starter -o ~/Ophelia

dotnet add package Aspire.Hosting.Oracle

#XML
<PackageReference Include="Aspire.Hosting.Oracle"
                  Version="*" />

# AppHost/Program.cs
var builder = DistributedApplication.CreateBuilder(args);

var oracle = builder.AddOracle("oracle")
                    .WithLifetime(ContainerLifetime.Persistent);

var oracledb = oracle.AddDatabase("oracledb");

builder.AddProject<Projects.ExampleProject>()
       .WithReference(oracledb);
       .WaitFor(oracledb);

# Add Oracle resource with passwd param 
var password = builder.AddParameter("password", secret: true);

var oracle = builder.AddOracle("oracle", password)
                    .WithLifetime(ContainerLifetime.Persistent);

var oracledb = oracle.AddDatabase("oracledb");

var myService = builder.AddProject<Projects.ExampleProject>()
                       .WithReference(oracledb)
                       .WaitFor(oracledb);

# Add Oracle resource with data volume, Passwd is stored in data volume!
var builder = DistributedApplication.CreateBuilder(args);

var oracle = builder.AddOracle("oracle")
                    .WithDataVolume()
                    .WithLifetime(ContainerLifetime.Persistent);

var oracledb = oracle.AddDatabase("oracle");

builder.AddProject<Projects.ExampleProject>()
       .WithReference(oracledb)
       .WaitFor(oracledb);

# Dev Env - Add Oracle resource with data bind mount 
var builder = DistributedApplication.CreateBuilder(args);

var oracle = builder.AddOracle("oracle")
                    .WithDataBindMount(source: @"C:\Oracle\Data");

var oracledb = oracle.AddDatabase("oracledb");

builder.AddProject<Projects.ExampleProject>()
       .WithReference(oracledb)
       .WaitFor(oracledb);

#JSON (Check)
{
  "Parameters": {
    "password": "Non-default-P@ssw0rd"
  }
}




## App.Client
public interface IHostApplicationBuilder
dotnet add package Aspire.Oracle.EntityFrameworkCore

# XML
<PackageReference Include="Aspire.Oracle.EntityFrameworkCore"
                  Version="*" />

# Program.cs
builder.AddOracleDatabaseDbContext<ExampleDbContext>(connectionName: "oracledb");
builder.AddOracleDatabaseDbContext<ExampleDbContext>("oracleConnection");

# Dependency Injection (DI)
public class ExampleService(ExampleDbContext context)
{
    // Use database context...
builder.Services.AddDbContext<ExampleDbContext>(options =>
    options.UseOracle(builder.Configuration.GetConnectionString("oracledb")
        ?? throw new InvalidOperationException("Connection string 'oracledb' not found.")));
}

# Enrich
builder.EnrichOracleDatabaseDbContext<ExampleDbContext>(
    configureSettings: settings =>
    {
        settings.DisableRetry = false;
        settings.CommandTimeout = 30 // seconds
    });

# appsettings.JSON
{
  "ConnectionStrings": {
    "oracleConnection": "Data Source=TORCL;User Id=OracleUser;Password=Non-default-P@ssw0rd;"
  }
}
{
  "Aspire": {
    "Oracle": {
      "EntityFrameworkCore": {
        "DisableHealthChecks": true,
        "DisableTracing": true,
        "DisableRetry": false,
        "CommandTimeout": 30
      }
    }
  }
}