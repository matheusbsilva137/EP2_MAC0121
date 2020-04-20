# Makefile do EP2

# Detecta o sistema operacional
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin) # Se for MACOS
	GLLIB = -framework OpenGL -framework GLUT -framework Cocoa
else 
	GLLIB = -lGL -lGLU -lglut
endif
CC     = gcc
CFLAGS = -Wall -O2 -std=c99 -pedantic -Wno-unused-result -Wno-deprecated-declarations

#------------------------------------------------


default :
	@echo "Para criar o tar, diga make tar NUSP=<NUSP> EMAIL=<EMAIL>."
	@echo "Para compilar o programa, diga make ep2."

tar:
	rm      -rf                     $(NUSP)
	rm      -f                      $(NUSP).tar

	mkdir                           $(NUSP)
	cp              cores.h         $(NUSP)/cores.h
	cp              graphic.c       $(NUSP)/graphic.c
	cp              graphic.h       $(NUSP)/graphic.h
	cp              imagem.c        $(NUSP)/imagem.c
	cp              imagem.h        $(NUSP)/imagem.h
	cp              io.c            $(NUSP)/io.c
	cp              io.h            $(NUSP)/io.h
	cp              main.c          $(NUSP)/main.c
	cp              main.h          $(NUSP)/main.h
	cp              Makefile        $(NUSP)/Makefile
	echo            $(EMAIL)      > $(NUSP)/email.txt
	echo            $(NUSP)       > $(NUSP)/nusp.txt

	tar     -cvf    $(NUSP).tar     $(NUSP)
	rm -rf                          $(NUSP)


ep2: main.o graphic.o imagem.o io.o
	$(CC) main.o graphic.o imagem.o io.o -o ep2 $(GLLIB) -lm

main.o: main.c imagem.h graphic.h io.h  
	$(CC) $(CFLAGS) -c main.c 

graphic.o: graphic.c graphic.h imagem.h  
	$(CC) $(CFLAGS) -c graphic.c 

imagem.o: imagem.c imagem.h
	$(CC) $(CFLAGS) -c imagem.c

io.o:   io.c io.h imagem.h
	$(CC) $(CFLAGS) -c io.c 

clean:
	$(RM) *~ *.o


