dotnet new aspire -o ~/Horatio
cd ~/Horatio

# Create requirements.txt (edit)
cat >> eof | sudo tee
Flask==3.0.3
opentelemetry-distro
opentelemetry-exporter-otlp-proto-grpc
opentelemetry-instrumentation-flask
gunicorn
>>

# Activate virtual environ and install requirements.txt
python -m venv .venv
source .venv/bin/activate
# Windows
# .venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# Create main.py, runserver.py (edit)
cat >> eof | sudo tee
"""
This script runs the Horatio application using a development server.
"""

from os import environ
from Horatio import app

if __name__ == '__main__':
    HOST = environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(environ.get('SERVER_PORT', '5555'))
    except ValueError:
        PORT = 5555
    app.run(HOST, PORT)
>>

# Create __init__.py
mkdir Flask
cd Flask
cat >> eof | sudo tee
import os
import logging
import flask
from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.instrumentation.flask import FlaskInstrumentor

app = flask.Flask(__name__)

trace.set_tracer_provider(TracerProvider())
otlpExporter = OTLPSpanExporter()
processor = BatchSpanProcessor(otlpExporter)
trace.get_tracer_provider().add_span_processor(processor)

FlaskInstrumentor().instrument_app(app)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

import Horatio.views
>>

# update projects launchsettings.json.
# The ASPIRE_ALLOW_UNSECURED_TRANSPORT variable is required because when
# running LOCALLY the OpenTelemetry client in Python rejects the local
# development certificate. UNDER "http": add 
"ASPIRE_ALLOW_UNSECURED_TRANSPORT": "true"

dotnet add ../Horatio.AppHost/Horatio.AppHost.csproj package Aspire.Hosting.Python --version 9.0.0

dotnet run --project ../Horatio.AppHost/Horatio.AppHost.csproj
