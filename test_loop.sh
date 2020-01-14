#!/bin/bash

for file in ./tests/*.sv; do
	echo "Testing file "$file
	verible/bazel-bin/verilog/tools/lint/verilog_lint -lint_fatal -ruleset all $file
	if [ $? -eq 0 ]; then
		echo "FAIL: undetected lint violation"
		echo $file | tee -a failed.log
	else
		echo "OK"
	fi
done

