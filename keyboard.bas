SCREEN 12
_FULLSCREEN _SQUAREPIXELS 'fullscreen and make it extra boxy

'Tuning:
CONST ConcertA4Freq = 440 'hz
CONST A4KeyNum = 49
CONST LowKeyNum = 28 'Left-most key: C3 Low C

DIM SHARED notes(31)

SetupNotes
SetupCursor

DO: _LIMIT 30 'set to 30 fps
    DO WHILE _MOUSEINPUT: LOOP
    DrawKeys
    IF _MOUSEBUTTON(1) THEN
        CALL PlayNote(_MOUSEX, _MOUSEY)
        _DELAY .1

    END IF
LOOP UNTIL INKEY$ = CHR$(27) 'exit on ESC key

FUNCTION NoteFreq (keyNum)
'See: http://en.wikipedia.org/wiki/Piano_key_frequencies
NoteFreq = (2 ^ ((keyNum - A4KeyNum) / 12)) * ConcertA4Freq
END FUNCTION

SUB SetupNotes
FOR i = 1 TO 31
    notes(i) = NoteFreq((LowKeyNum - 1) + i)
NEXT
END SUB

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
