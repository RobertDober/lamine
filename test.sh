#!/usr/bin/env bash

echo "testing"

# for dir in $(find tests -type dir); do
#  nvim --headless -c "lua require'plenary.test_harness'" -c "PlenaryBustedDirectory ${dir} {sequential=true, timeout=10000}" || exit 1
# done

nvim  -c "lua require'plenary.test_harness'" -c "PlenaryBustedFile tests/context/get_lines_spec.lua {sequential=true, timeout=10000}"

# SPDX-License-Identifier: AGPL-3.0-or-later
