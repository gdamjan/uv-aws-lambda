import boto3

import os
import sys
import logging

logger = logging.getLogger(__name__)
logger.setLevel("INFO")


def main() -> None:
    print("Hello from main()!")


def lambda_handler(event, context):
    print("print from lambda_handler() to stderr", file=sys.stderr)
    logger.info(os.environ)

    sts = boto3.client("sts")
    identity = sts.get_caller_identity()
    logger.info(identity)

    return event
