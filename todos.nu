#!/usr/bin/env nu
let todos = rg -N '# TODO #\d{6}' --json
