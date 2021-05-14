// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.


(REDRAW)
  // Store the current key press.
  @KBD
  D = M
  @keypress
  M=D

  @i
  M = 0
  (LOOP)
    @i
    D = M

    // D == 0; we're finished drawing the screen, redraw.
    @8192 // 256 * 512 / 16
    D = D - A
    @REDRAW
    D;JEQ

    @keypress
    D = M
    // D == 0; draw white
    @PAINT_WHITE
    D;JEQ
    // D != 0; draw black
    @PAINT_BLACK
    0;JMP

    (CONTINUE)
    @i
    M = M + 1

    @LOOP
    0;JMP

(PAINT_BLACK)
  @i
  D = M

  // Draw at RAM[16384 + i]
  @SCREEN
  A = A + D
  M = -1 // -1 is 1111111111111111 (white)

  @CONTINUE
  0;JMP

(PAINT_WHITE)
  @i
  D = M

  // Draw at RAM[16384 + i]
  @SCREEN
  A = A + D
  M = 0 // 0 is 0000000000000000 (black)

  @CONTINUE
  0;JMP
