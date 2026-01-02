import smtplib
from email.mime.text import MIMEText
from log_monitor import log_info

SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
EMAIL_USER = "youremail@gmail.com"
EMAIL_PASSWORD = "yourpassword"

def send_email(subject, body, to_addresses):
    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = EMAIL_USER
    msg["To"] = ", ".join(to_addresses)

    try:
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(EMAIL_USER, EMAIL_PASSWORD)
        server.sendmail(EMAIL_USER, to_addresses, msg.as_string())
        server.quit()
        log_info(f"Email sent to {to_addresses}")
    except Exception as e:
        log_info(f"Failed to send email: {e}")
