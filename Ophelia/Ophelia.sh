
dotnet new install Aspire.ProjectTemplates
dotnet new aspire-starter -o ~/Ophelia

## Add Projects to Aspire
mkdir ~/Ophelia/Ophelia.Flask
mkdir ~/Ophelia/Ophelia.AppDB


cd ~/Ophelia/Ophelia.Flask
python -m venv .venv
source .venv/bin/activate
# Windows
# .venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install PyQt6 PyQtWebEngine

# Create requirements.txt
cat <<EOF | sudo tee /Ophelia/flask/requirements.txt
Flask==3.0.3
Flask-SQLAlchemy
Authlib
EOF

# Create main.py, runserver.py
cat <<EOF | sudo tee /Ophelia/flask/main.py
import os
import flask
EOF

python -m pip install -r requirements.txt

## App.AppHost
cd ~/Ophelia/Ophelia.AppHost

## Packages
dotnet add package CommunityToolkit.Aspire.Hosting.Rust
dotnet add package CommunityToolkit.Aspire.Hosting.Golang
dotnet add package Aspire.Hosting.Oracle
dotnet add ../Ophelia.AppHost/Ophelia.AppHost.csproj package Aspire.Hosting.Python --version 9.0.0

# XML
<PackageReference Include="CommunityToolkit.Aspire.Hosting.Rust"
                  Version="*" />
<PackageReference Include="CommunityToolkit.Aspire.Hosting.Golang"
                  Version="*" />
<PackageReference Include="Aspire.Hosting.Oracle"
                  Version="*" />
<PackageReference Include="Aspire.Hosting.Python" Version="9.4.0" />                  

# Program.cs
var builder = DistributedApplication.CreateBuilder(args);

var catalog = builder.AddProject<Projects.CatalogService>("catalog");
var basket = builder.AddProject<Projects.BasketService>("basket")
    .WithHttpsEndpoint(hostPort: 9999, name: "dashboard");

var frontend = builder.AddProject<Projects.MyFrontend>("frontend")
                      .WithReference(basket)
                      .WithReference(catalog);

var rust = builder.AddRustApp("rust-app", workingDirectory: "../rust-service”, args: [“—locked”])
                 .WithHttpEndpoint(env: "PORT");

var exampleProject = builder.AddProject<Projects.ExampleProject>()
                            .WithReference(rust);

var golang = builder.AddGolangApp("golang", "../gin-api")
    .WithHttpEndpoint(env: "PORT");

#pragma warning disable ASPIREHOSTINGPYTHON001
var pythonapp = builder.AddPythonApp("hello-python", "../hello-python", "main.py")
       .WithHttpEndpoint(env: "PORT")
       .WithExternalHttpEndpoints()
       .WithOtlpExporter();
#pragma warning restore ASPIREHOSTINGPYTHON001

if (builder.ExecutionContext.IsRunMode && builder.Environment.IsDevelopment())
{
    pythonapp.WithEnvironment("DEBUG", "True");
}

builder.Build().Run();



# Add two HTTPClient classes
builder.Services.AddHttpClient<BasketServiceClient>(
    static client => client.BaseAddress = new("https+http://basket"));

builder.Services.AddHttpClient<BasketServiceDashboardClient>(
    static client => client.BaseAddress = new("https+http://_dashboard.basket"));

## If using Podman, Aspire defaults to Docker
# export ASPIRE_CONTAINER_RUNTIME=podman
# Option 1: Create a symbolic link
# sudo ln -s /path/to/podman-remote-static-linux_amd64 /usr/local/bin/podman
# Option 2: Add to PATH in your shell profile
# echo 'export PATH="/path/to/podman/directory:$PATH"' >> ~/.bashrc
# source ~/.bashrc
# which podman
# podman --version

## Aspire CLI (Powershell)
# Invoke-Expression "& { $(Invoke-RestMethod https://aspire.dev/install.ps1) }"
# Invoke-Expression "& { $(Invoke-RestMethod https://aspire.dev/install.ps1) } -InstallPath 'C:\Tools\Aspire' -“Verbose”







flask --app __init__.py run