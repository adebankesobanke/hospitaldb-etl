import requests
from log_monitor import log_info

SLACK_WEBHOOK_URL = "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

def send_slack_message(message: str):
    payload = {"text": message}
    response = requests.post(SLACK_WEBHOOK_URL, json=payload)
    if response.status_code == 200:
        log_info(f"Slack message sent: {message}")
    else:
        log_info(f"Failed to send Slack message: {response.text}")
