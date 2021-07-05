# Verible style guide coverage tester

Copyright (c) 2020-2021 [Antmicro](https://www.antmicro.com)

This repository contains test files and scripts for checking the extent to which
[Verible](https://github.com/google/verible) covers Basic Style Elements section
of the [lowRISC style guide](https://github.com/lowRISC/style-guides/blob/master/VerilogCodingStyle.md).

## Repository structure

* `tests/formatter` - files with single formatting violations to be fixed by `verilog_format`
* `tests/linter` - files with single linting violations to be reported by `verilog_lint`

Apart from those tests the linter is also run on [Ibex RISC-V Core](https://github.com/lowRISC/ibex)
files that are included as a submodule.

## Usage

### Prerequisites

* [bazel](https://bazel.build/)
* C++17 compatible compiler

### Setup
```
# Clone the repository
git clone --recursive https://github.com/antmicro/verible-coverage.git

# Clone and build Verible
git clone https://github.com/google/verible.git verible
cd verible && bazel build --noshow_progress --cxxopt='-std=c++17' //...

# Run the test script
./test_loop.sh
```
