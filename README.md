# AWS Lambda python managed by uv

**Obsoleted by:** https://docs.astral.sh/uv/guides/integration/aws-lambda/

This python demo project is managed by [uv](https://docs.astral.sh/uv) -
the next gen python package and project manager.

The trick to make this work, is to copy the files/directories from
`.venv/lib/python${PYTHON_VERSION}/site-packages/` to `/var/task/` flat.
Also you must specify `--no-editable` in `uv sync` so that the project is not symlinked.

Project created with `uv init --package`, which uses the
[`src/` layout](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/)
and the [uv build](https://docs.astral.sh/uv/concepts/build-backend/) system.

It's an opinionated setup, but I don't wanna hear anything against it 😁.

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
