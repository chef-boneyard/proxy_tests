#!/bin/bash
run_cmd timeout -k 60 -s 9 60 kitchen driver discover || PROXY_TEST_RESULT=failed

# TODO expand these to do more stuff with TK
