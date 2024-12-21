#!/usr/bin/env python

import time
from subprocess import DEVNULL, run

startup_log_file: str = "tmp_" + str(time.time()).replace(".", "_")


def get_time(filepath: str = startup_log_file):
    # we want the second line that contains nvim started
    # TODO: is there a better way to get this
    found = False
    with open(filepath, "r") as file:
        for i in file.readlines():
            if "NVIM STARTED" in i:
                time = i.split()[0]
                if found:
                    return time
                found = True


time = lambda: get_time()

for i in range(5):
    print(f"Warmup #{i+1}")
    run(["nvim", "-c", "q"], stdout=DEVNULL, stderr=DEVNULL)


run(["nvim", "--clean", "-nu", "NORC", "--startuptime", startup_log_file])
print(f"No config: {time()}ms")
run(["rm", startup_log_file])

run(["nvim", "--startuptime", startup_log_file])
print(f"With config: {time()}ms")
run(["rm", startup_log_file])

run(["nvim", "tmp.lua", "--startuptime", startup_log_file])
print(f"Opening init.lua: {time()}ms")
run(["rm", startup_log_file])

run(["nvim", "tmp.py", "--startuptime", startup_log_file])
print(f"Opening Python file: {time()}ms")
run(["rm", startup_log_file])

run(["nvim", "tmp.cpp", "--startuptime", startup_log_file])
print(f"Opening CPP file: {time()}ms")
run(["rm", startup_log_file])

run(["nvim", "tmp.go", "--startuptime", startup_log_file])
print(f"Opening Go file: {time()}ms")
run(["rm", startup_log_file])

run(["nvim", "tmp.rs", "--startuptime", startup_log_file])
print(f"Opening Rust file: {time()}ms")
run(["rm", startup_log_file])
