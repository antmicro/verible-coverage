#!/bin/bash

rm -f failed.log

for file in ./tests/*.sv; do
    echo "------------"
    echo "Testing file "$file
    verible/bazel-bin/verilog/tools/lint/verilog_lint -lint_fatal -ruleset all $file
    if [ $? -eq 0 ]; then
        echo "FAIL: expected a lint violation"
        echo $file >> failed.log
    else
        echo "OK"
    fi
done

printf "\n%s\n%s\n" "Undetected lint violations in:" "$(cat failed.log)"
