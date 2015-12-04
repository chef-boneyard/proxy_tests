#!/bin/bash
run_cmd kitchen driver discover || PROXY_TEST_RESULT=failed
