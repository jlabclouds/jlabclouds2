dotnet new aspire -o ~/Ophelia
cd ~/Ophelia

mkdir flask

cd flask

python -m venv .venv

source .venv/bin/activate
# Windows
# .venv\Scripts\Activate.ps1

python -m pip install --upgrade pip

# Create requirements.txt (edit)
cat << eof | sudo tee
Flask==3.0.3
opentelemetry-distro
opentelemetry-exporter-otlp-proto-grpc
opentelemetry-instrumentation-flask
gunicorn
<

python -m pip install -r requirements.txt

# Create main.py, runserver.py (edit)
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

@app.route('/', methods=['GET'])
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8111))
    debug = bool(os.environ.get('DEBUG', False))
    host = os.environ.get('HOST', '127.0.0.1')
    app.run(port=port, debug=debug, host=host)
>>

# update projects launchsettings.json.
# The ASPIRE_ALLOW_UNSECURED_TRANSPORT variable is required because when
# running LOCALLY the OpenTelemetry client in Python rejects the local
# development certificate. UNDER "http": add 
"ASPIRE_ALLOW_UNSECURED_TRANSPORT": "true"

dotnet add ../Ophelia.AppHost/Ophelia.AppHost.csproj package Aspire.Hosting.Python --version 9.0.0

dotnet run --project ../Ophelia.AppHost/Ophelia.AppHost.csproj
