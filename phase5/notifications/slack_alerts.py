import requests
<<<<<<< HEAD

def send_slack_alert(message: str, webhook_url: str):
    """
    Send a Slack message via Incoming Webhook.

    Args:
        message (str): The message text to send.
        webhook_url (str): The Slack webhook URL.
    """
    payload = {"text": message}
    response = requests.post(webhook_url, json=payload)
    if response.status_code != 200:
        raise ValueError(
            f"Request to Slack returned {response.status_code}, response: {response.text}"
        )

# Example usage
if __name__ == "__main__":
    webhook_url = "https://hooks.slack.com/services/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"
    send_slack_alert("✅ ETL refresh completed successfully!", webhook_url)
=======
from log_monitor import log_info

SLACK_WEBHOOK_URL = "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

def send_slack_message(message: str):
    payload = {"text": message}
    response = requests.post(SLACK_WEBHOOK_URL, json=payload)
    if response.status_code == 200:
        log_info(f"Slack message sent: {message}")
    else:
        log_info(f"Failed to send Slack message: {response.text}")
>>>>>>> 6af9b5afdd4ce94ec461b6cc25b17afbd2b33376
