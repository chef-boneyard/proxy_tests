#!/bin/bash
run_cmd timeout -k 30 -s 9 30 kitchen driver discover || PROXY_TEST_RESULT=failed
