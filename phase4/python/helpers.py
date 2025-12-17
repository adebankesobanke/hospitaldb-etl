import pandas as pd
import logging
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from config import DB_CONFIG, LOG_PATH

# Logging Setup
logging.basicConfig(
    filename=LOG_PATH,
    level=logging.INFO,
    format="%(asctime)s — %(levelname)s — %(message)s"
)

def create_db_engine():
    """Create SQLAlchemy engine for PostgreSQL."""
    try:
        url = (
            f"postgresql+psycopg2://{DB_CONFIG['user']}:{DB_CONFIG['password']}"
            f"@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"
        )
        engine = create_engine(url)
        logging.info("Database engine created successfully.")
        return engine
    except SQLAlchemyError as e:
        logging.error(f"Error creating DB engine: {e}")
        raise e


def load_csv_to_table(csv_path, table_name, engine):
    """Load local CSV file into a database table."""
    try:
        df = pd.read_csv(csv_path)
        df.to_sql(table_name, engine, if_exists="replace", index=False)
        logging.info(f"Loaded {len(df)} records into {table_name}.")
    except Exception as e:
        logging.error(f"Error loading {csv_path} into {table_name}: {e}")
        raise e


def run_sql_file(engine, filepath):
    """Execute a SQL file inside the database."""
    try:
        with open(filepath, "r") as file:
            query = text(file.read())
            engine.execute(query)
            logging.info(f"Executed SQL file: {filepath}")
    except Exception as e:
        logging.error(f"SQL file execution error ({filepath}): {e}")
        raise e


def run_data_quality_check(engine, description, query):
    """Run a SQL DQ check and log results."""
    try:
        result = engine.execute(text(query)).fetchall()
        failed = len(result)
        if failed > 0:
            logging.warning(f"DQ WARNING — {description}: {failed} failed rows")
        else:
            logging.info(f"DQ PASSED — {description}")
    except Exception as e:
        logging.error(f"DQ check error — {description}: {e}")
        raise e
