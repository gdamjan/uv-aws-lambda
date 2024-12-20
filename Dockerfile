# syntax=docker/dockerfile:1

# Define Python version as an argument
ARG PYTHON_VERSION=3.12

## Builder image with python and uv
FROM python:${PYTHON_VERSION}-slim AS builder
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN <<EOF
    uv --version
    python --version
EOF

ENV \
    UV_CACHE_DIR=/cache \
    UV_LINK_MODE=copy \
    UV_SYSTEM_PYTHON=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_COMPILE_BYTECODE=1 \
    UV_LOCKED=1

WORKDIR /src
# 2-step install, first dependencies, then the project itself
#
# `UV_LOCKED=1` - makes sure the uv.lock file is in sync with `pyproject.toml`

# Install dependencies in their own layer
RUN --mount=type=cache,target=/cache \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --no-dev --no-editable --no-install-project

# Copy the project into the builder - COPY is affected by `.dockerignore`
COPY . /src

# Sync the whole project
RUN --mount=type=cache,target=/cache \
    uv sync --no-dev --no-editable


## Runtime image
FROM public.ecr.aws/lambda/python:${PYTHON_VERSION}
ARG PYTHON_VERSION

COPY --from=builder /src/.venv/lib/python${PYTHON_VERSION}/site-packages/ ${LAMBDA_TASK_ROOT}

CMD [ "demo.lambda_handler" ]
