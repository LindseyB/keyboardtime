SCREEN 12
_FULLSCREEN _SQUAREPIXELS 'fullscreen and make it extra boxy

'notes are weird and have no freq pattern
DIM SHARED notes(31)
' starting gross array loading
notes(1) = 131
notes(2) = 139
notes(3) = 147
notes(4) = 156
notes(5) = 165
notes(6) = 175
notes(7) = 185
notes(8) = 196
notes(9) = 208
notes(10) = 220
notes(11) = 233
notes(12) = 247
notes(13) = 262
notes(14) = 277
notes(15) = 294
notes(16) = 311
notes(17) = 330
notes(18) = 349
notes(19) = 370
notes(20) = 392
notes(21) = 415
notes(22) = 440
notes(23) = 466
notes(24) = 494
notes(25) = 523
notes(26) = 554
notes(27) = 587
notes(28) = 622
notes(29) = 659
notes(30) = 698
notes(31) = 740
'end disgusting array loading

SetupCursor
DO: _LIMIT 30 'set to 30 fps
    DO WHILE _MOUSEINPUT: LOOP
    DrawKeys
    IF _MOUSEBUTTON(1) THEN
        CALL PlayNote(_MOUSEX, _MOUSEY)
        _DELAY .1

    END IF
LOOP UNTIL INKEY$ = CHR$(27) 'exit on ESC key

SUB SetupCursor
ON TIMER(0.02) UpdateCursor
TIMER ON
END SUB

SUB UpdateCursor
PCOPY _DISPLAY, 100
mouseColor = 8
IF _MOUSEBUTTON(1) THEN
    mouseColor = 12
END IF
PSET (_MOUSEX, _MOUSEY), mouseColor
DRAW "ND10F10L3F5L4H5L3" 'mouse cursor shape
_DISPLAY
PCOPY 100, _DISPLAY
END SUB

SUB DrawKeys
'creating a new image for the surface to prevent key flickering
a& = _NEWIMAGE(640, 480, 12)
_DEST a& ' makes image default drawing surface
'draw the white keys
FOR i = 0 TO 30
    'draw white key outline
    LINE (10 + (i * 20), 100)-(30 + (i * 20), 250), 7, B
    'fill the white keys
    PAINT (11 + (i * 20), 101), 15, 7
NEXT

'drawing black keys
FOR i = 0 TO 14
    LINE (22 + (i * 40), 100)-(38 + (i * 40), 180), 0, BF
NEXT

UpdateCursor 'keeps the cursor from flickering
_PUTIMAGE (0, 0)-(640, 480), a&, 0, (0, 0)-(640, 480)

END SUB

SUB PlayNote (x, y)
IF (y > 100 AND y < 250) AND (x > 10 AND x < 630) THEN
    SOUND notes((x / 20)), 1
END IF
END SUB
