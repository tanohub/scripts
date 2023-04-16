#!/usr/bin/env python3

import syslog
from datetime import datetime

now = datetime.now()

today = now.strftime("%d/%m/%Y %H:%M:%S")

syslog_string = today + " -- Sending a log message through syslog_module!"
syslog.syslog(syslog_string)
