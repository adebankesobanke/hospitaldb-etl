def notify_failure(context):
    """
    Simple Airflow failure notification.
    Replace the print statement with Slack or email API as needed.
    """
    task = context.get('task_instance')
    dag_id = task.dag_id
    task_id = task.task_id
    execution_date = context.get('execution_date')
    
    print(f"[ALERT] DAG '{dag_id}', task '{task_id}' failed on {execution_date}")
