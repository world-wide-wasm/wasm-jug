#!/bin/bash
LD_LIBRARY_PATH=/usr/local/lib ./mvnw clean package

ls -lh ./target/*.jar
