.SILENT: all

CC=gcc
CXX=g++
CXX_FLAGS=-lgtest -lgtest_main -pthread

all: example1.final example2.final example3.final

%.out: %.cpp
	@echo "building $*"
	${CXX} $< ${CXX_FLAGS} -o $@

%.final: %.out
	./$<

clean:
	rm -rf *.out