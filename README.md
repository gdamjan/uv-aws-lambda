# AWS Lambda python managed by uv

This python demo project is managed by [uv](https://docs.astral.sh/uv) -
the next gen python package and project manager.

The trick to make this work, is to copy the files/directories from
`.venv/lib/python${PYTHON_VERSION}/site-packages/` to `/var/task/` flat.
Also you must specify `--no-editable` in `uv sync` so that the project is not symlinked.

Project created with `uv init --app --package`, which uses the
[`src/` layout](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/)
(which I prefer anyway).

## Quickstart

```
podman build -t demo-uv-aws-lambda .
podman run --rm -p 9000:8080 demo-uv-aws-lambda
```

In another terminal/shell
```
curl "http://localhost:9000/2015-03-31/functions/function/invocations" \
    -d '{"payload":"hello world!"}'
```

## Caveat

- I build the project with the `python:3.12-slim` image, but then deploy it in a
  `public.ecr.aws/lambda/python:3.12` based runtime image. That would most probably
  create issues for binary dependencies/packages. TBD.

- `logging` doesn't work, at least in the local tests. TBD.
  `print` does work.
