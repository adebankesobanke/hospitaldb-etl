import logging
from log_monitor import log_error

def track_exception(e, task_name="Unknown Task"):
    """Log exceptions with context."""
    error_message = f"Error in {task_name}: {str(e)}"
    log_error(error_message)
