#!/bin/bash
clear
bat $0 --line-range 5:
echo ""
hey -n 3000 -c 500 -m POST \
-d 'John Doe' \
"http://localhost:8082" 
