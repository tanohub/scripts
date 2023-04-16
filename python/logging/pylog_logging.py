#!/usr/bin/env python3

import os
import logging
from logging.handlers import SysLogHandler
from datetime import datetime

now = datetime.now()
today = now.strftime("%d/%m/%Y %H:%M:%S")
syslog_string = today + " -- Sending a log message through logging_module!"

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
handler = SysLogHandler(
    facility=SysLogHandler.LOG_DAEMON,
    address='/dev/log'
    )
handler.ident = os.path.relpath(__file__) + " "
logger.addHandler(handler)
logger.debug( syslog_string)
