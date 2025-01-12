import azure.functions as func
import datetime
import json
import logging

app = func.FunctionApp()

@app.route(route="httpfun", auth_level=func.AuthLevel.ANONYMOUS)
def main(req: func.HttpRequest) -> func.HttpResponse:
    # Get the 'name' parameter from the query string or request body
    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    # Generate response based on whether a name was provided
    if name:
        return func.HttpResponse(f"Hello, {name}! Welcome to Azure Functions.", status_code=200)
    else:
        return func.HttpResponse("Hello! Please provide your name.", status_code=400)

