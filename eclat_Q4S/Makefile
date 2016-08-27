########################################################
#
#	Name:YUANKUN FU
#	Course name: DataMining
#	Homework Number: 1
#	Brief desc of the file: Makefile
#
########################################################

## Compiler, tools and options
# define the compiler to use
CC      = g++
LINK    = g++
OPT     = -O3
DEBUG	= -g
# define any compile-time flags
CCFLAGS = -Wall $(DEBUG) -std=c++0x

LDFLAGS = -Wall $(DEBUG)

## Libraries
# define any libraries to link into executable:
# if I want to link in libraries (libx.so or libx.a) I use the -llibname option:
LIBS =
INC  = -I.

## FILES
OBJECTS = main.o function.o
TARGET  = eclat

## Implicit rules
.SUFFIXES: .C
.C.o:
	$(CC) -c $(CCFLAGS) $(INC) $<

## Build rules
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LINK) -o $@ $(OBJECTS) $(LDFLAGS) $(LIBS)


clean:
	rm -f $(OBJECTS) $(TARGET)
	rm -f *~ core
