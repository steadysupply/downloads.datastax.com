import datetime
import time
import json
import os

from pyspark import SparkConf, SparkContext, HiveContext
from pyspark.sql import Row

conf = SparkConf()
conf.setMaster("spark://{0}:7077".format(os.environ['SPARK_IP']))
conf.setAppName("Cubik/Origami POC")
sc = SparkContext(conf=conf)

hive = HiveContext(sc)
hive.sql('USE et3_sample_2017')

EXTRACT_VALUE = '''regexp_extract(value, '"value":(\\\d+)', 1)'''

SUM_KW = '''
sum(CASE WHEN label='Pa' OR label='Pb' OR label='Pc' THEN {extract_value} ELSE 0 END)
'''.format(extract_value=EXTRACT_VALUE)

SUM_KVAR = '''
sum(CASE WHEN label='Qa' OR label='Qb' OR label='Qc' THEN {extract_value} ELSE 0 END)
'''.format(extract_value=EXTRACT_VALUE)

BASE_QUERY = '''
    SELECT
        host,
        {sum_kw} kw,
        {sum_kvar} kvar
    FROM metrology
    WHERE stamp > {start}
    GROUP BY host
'''

TOTAL_QUERY = BASE_QUERY.format(sum_kw=SUM_KW, sum_kvar=SUM_KVAR, start=0)
hive.sql(TOTAL_QUERY).show()

START = int(((datetime.datetime.now() - datetime.timedelta(days=30)) - datetime.datetime(1970, 1, 1)).total_seconds())
MONTH_QUERY = BASE_QUERY.format(sum_kw=SUM_KW, sum_kvar=SUM_KVAR, start=START)
hive.sql(MONTH_QUERY).show()
