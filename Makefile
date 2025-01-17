SRCDIR=./src/
INCLUDEDIR=./include/
OBJDIR=./obj/
BINDIR=./bin/

CXX=gcc

CFLAGS=-pedantic -Wall -std=gnu99 -O3 -I$(INCLUDEDIR)
LIBS=-lpigpio

DEPS = functions.h
SRCS = fan.c functions.c

OBJS := $(addprefix $(OBJDIR),$(SRCS:.c=.o))
SRCS := $(addprefix $(SRCDIR),$(SRCS))
DEPS := $(addprefix $(INCLUDEDIR),$(DEP))

fanService: $(OBJS)
	$(CXX) $(CFLAGS) -o $(BINDIR)$@ $^ $(LIBS)

$(OBJDIR)%.o: $(SRCDIR)%.c $(DEPS) dirs
	$(CXX) $(CFLAGS) -c -o $@ $<

dirs:
	mkdir -p $(OBJDIR)
	mkdir -p $(BINDIR)

.PHONY: clean all ver install


all: fanService
clean:
	rm -f $(OBJDIR)*
ver:
	$(CXX) --version
install:
	echo "Installing FanService into /opt/FanService"
