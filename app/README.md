# Simple Flask Web Application

This directory contains code for a simple Flask web application.

## Structure

- `hello-world.py`: Main Flask application code
- `requirements.txt`: List of Python module dependencies
- `Dockerfile`: building the Docker image of the Flask application

## Setup Instructions

### Prerequisites

- Python 3.12

### 1. Install Dependencies

Python version is specified in the `.mise.toml` file at the root of the repository.
Please refer to [`mise` site](https://mise.jdx.dev) for more information.

It is recommended to create and activate a virtual environment before installing
the dependencies:

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 2. Run the Application

You can start the Flask application locally:

```shell
python3 hello-world.py
```

The application will be available at [127.0.0.1:8080](http://127.0.0.1:8080).

### Docker

A Dockerfile is provided to build the application image.

To build and run the Docker container:

```shell
docker build -t hello-world .
```

You can then run the container:

```shell
docker run -p 8080:8080 hello-world
```

### Environment Variables

The following environment variables can be used to configure the application:

- `APP_HOST`: Flask application hostname (default: `0.0.0.0`)
- `APP_PORT`: Flask application port (default: `8080`)
