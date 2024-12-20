import boto3

import os, sys
import logging

logger = logging.getLogger(__name__)
logger.setLevel("INFO")

def main() -> None:
    print("Hello from main()!")

def lambda_handler(event, context):
    print("print from lambda_handler() to stderr", file=sys.stderr)
    logger.info(os.environ)
    return event
