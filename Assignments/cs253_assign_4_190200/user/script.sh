#!/bin/bash

echo "Running Vulnerable File"
python3 vuln.py test.in > vuln.out
echo "Outputs saved to vuln.out"
echo
echo "Running Safe File"
python3 safe.py test.in > safe.out
echo "Outputs saved to safe.out"