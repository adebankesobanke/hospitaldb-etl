import logging
from pathlib import Path

# Logging configuration
LOG_DIR = Path("phase5/logs")
LOG_DIR.mkdir(parents=True, exist_ok=True)

logging.basicConfig(
    filename=LOG_DIR / "etl.log",
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

def log_info(message):
    logging.info(message)
    print(f"[INFO] {message}")

def log_error(message):
    logging.error(message)
    print(f"[ERROR] {message}")
