DESTDIR?=/usr/local/lib/cc65/
INCLUDES?=/usr/local/include/cc65/

SOURCES_asm= \
    burn.asm \
    bank-offset.asm \
    c-copy.asm \
    commands.asm \
    copy.asm \
    erase.asm \
    readwrite.asm \
    unhide.asm \
    zeropage.asm

LIBRARY=libultimem.a

include Makefile.rules

%.o: %.asm
	$(AS) -g -o $@ $<

%.o: %.c
	$(CC) -O -c $(CFLAGS) -I../ingle/ -o $@ $<

$(LIBRARY): $(SOURCES_asm:.asm=.o)
	$(AR) a $@ $^

all: $(LIBRARY)

clean:
	rm -f $(SOURCES_asm:.asm=.o) $(LIBRARY)

install:
	mkdir -p $(DESTDIR)
	cp libultimem.a $(DESTDIR)/
	mkdir -p $(INCLUDES)
	cp ultimem.h $(INCLUDES)/
