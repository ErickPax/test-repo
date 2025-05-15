#############################################################################
# File name:  Makefile
# Author:     Erick Paxtian
# Date:       April 2025
# Purpose:    Dictate common complie commands
#############################################################################

all: bin bin/main

ENCSRIPT_FLAGS=-C -T 2 -p - -M Letter -Ecpp --color -fCourier8
VALGRIND_FLAGS=-v --leak-check=yes --track-origins=yes --leak-check=full --show-leak-kinds=all 

compiler=g++
CPP_VERSION=c++2a

bin:
	mkdir -p bin

bin/main: bin src/*.cpp include/*.h
	${compiler} -std=${CPP_VERSION} -o bin/main -g -Wall src/*.cpp -Iinclude

valgrind: bin/main
	valgrind ${VALGRIND_FLAGS} bin/main 

printAll:
	enscript ${ENCSRIPT_FLAGS} src/*.cpp include/*.h  | ps2pdf - bin/src.pdf

runMe: bin/main
	bin/main
	
clean:
	rm -rf bin/main bin/*.o bin/main.dSYM bin/*.pdf