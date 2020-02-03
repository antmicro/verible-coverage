#!/bin/bash

rm -f failed.log
mkdir -p formatted

echo "********************************************************************************"
printf "\n\t%s\n\n" "Linter tests "
echo "********************************************************************************"

for original_file in ./tests/linter/*.sv; do
    echo "------------"
    echo "Testing file "$original_file
    verible/bazel-bin/verilog/tools/lint/verilog_lint -lint_fatal -ruleset all $original_file
    if [ $? -eq 0 ]; then
        echo "FAIL: expected a lint error"
        echo $original_file >> failed.log
    else
        echo "OK"
    fi
done

echo "********************************************************************************"
printf "\n\t%s\n\n" "Formatter tests "
echo "********************************************************************************"

for original_file in ./tests/formatter/*.sv; do
    echo "------------"
    echo "Testing file "$original_file
    filename=$(basename $original_file)

    verible/bazel-bin/verilog/tools/formatter/verilog_format $original_file > ./formatted/$filename

    diff $original_file ./formatted/$filename
    if [ $? -eq 0 ]; then
        echo "FAIL: expected a correction from formatter"
        echo $original_file >> failed.log
    else
        echo "OK"
    fi

    verible/bazel-bin/verilog/tools/lint/verilog_lint -lint_fatal -ruleset all $original_file
    if [ $? -ne 0 ]; then
        echo "FAIL: expected no lint errors after formatting"
        echo $original_file >> failed.log
    else
        echo "OK"
    fi
done

printf "\n%s\n%s\n" "Undetected violations in:" "$(cat failed.log)"

echo "********************************************************************************"
printf "\n\t%s\n\n" "Linting files from Ibex "
echo "********************************************************************************"

for file in ./ibex/rtl/*.sv; do
    echo "------------"
    echo "Linting file "$file
    verible/bazel-bin/verilog/tools/lint/verilog_lint -lint_fatal -ruleset all $file
    if [ $? -eq 0 ]; then
        echo "- No lint violations."
    fi
done
