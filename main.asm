; a short program to check how
; set and get pixel color works

name "pixel"

org  100h

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
int 10h     ; set it!


mov cx, 10
mov dx, 20
lea si, sprite_pikamini
call show_sprite


; pause the screen for dos compatibility:

;wait for keypress
mov ah,00
int 16h			

	
ret

;#afficher un pixel#
;
;cx colonne
;dx ligne
;               
;al couleur
;   0 black
;   1 blue
;   2 green
;   3 cyan
;   4 red
;   5 magenta
;   6 brown
;   7 light gray
;   8 dark gray
;   9 light blue
;   A light green
;   B light cyan
;   C light red
;   D light magenta
;   E yellow      
;   F white
;
;mov ah, 0ch
;int 10h                      

sprite_pikamini_w DW 030h
sprite_pikamini_h DW 030h
sprite_pikamini DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_1 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_3 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_4 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,07h,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_5 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_6 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,01h,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_7 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,09h,01h,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_8 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,04h,01h,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_9 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,01h,01h,0ah,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_a DB 0fh,0fh,0eh,0ah,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,09h,01h,01h,09h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_b DB 0fh,0fh,0fh,06h,01h,01h,04h,08h,0bh,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0eh,0fh,0fh,0fh,0fh,0fh,0bh,04h,01h,09h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_c DB 0fh,0fh,0fh,0fh,07h,01h,01h,01h,01h,01h,04h,09h,0dh,0eh,0fh,0fh,0eh,0ch,0ch,0ch,0eh,0eh,0dh,0ch,0ch,0fh,0fh,0ch,0fh,03h,0ah,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_d DB 0fh,0fh,0fh,0fh,0fh,0ah,02h,02h,02h,02h,06h,0fh,0fh,0eh,0dh,0bh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0ah,0dh,0fh,0fh,0dh,09h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_e DB 0fh,0fh,0fh,0fh,0fh,0fh,0dh,03h,01h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0ah,0fh,0fh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_f DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,09h,05h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0eh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_10 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,0eh,0fh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_11 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ah,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,0fh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_12 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0eh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,04h,0fh,0fh,0fh,0dh,0dh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_13 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0eh,0fh,0fh,0fh,0fh,0fh,0eh,02h,0fh,0fh,0fh,0fh,0fh,04h,0fh,0fh,0fh,0fh,0ah,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_14 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0ch,0ah,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0eh,0fh
sprite_pikamini_line_15 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0ah,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,04h,02h,0eh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0ch,0ch,0dh,0eh,0fh
sprite_pikamini_line_16 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,09h,01h,08h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,07h,03h,0fh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0bh,0bh,0fh,0fh,0fh,0ch,0fh,0fh
sprite_pikamini_line_17 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0bh,01h,05h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,0bh,0eh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh
sprite_pikamini_line_18 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0fh,0fh,0fh,0fh,0ch,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0dh,0bh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh
sprite_pikamini_line_19 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ah,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0ah,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh
sprite_pikamini_line_1a DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,0fh,0fh,0fh,0fh,0fh,0bh,0fh,0fh,0ah,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ah,0bh,0eh,0fh,0fh
sprite_pikamini_line_1b DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ah,0bh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0ah,0fh,0fh,0fh,0fh,0fh,0dh,08h,09h,0eh,0fh,0fh,0fh,0fh
sprite_pikamini_line_1c DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0ah,0fh,0fh,0fh,0eh,09h,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_1d DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0ch,0ch,0bh,0fh,0fh,0ah,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_1e DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,0bh,0bh,0bh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_1f DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,08h,0fh,08h,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_20 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,09h,01h,09h,0dh,0fh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_21 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,08h,06h,0fh,0ah,0dh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_22 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0eh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_23 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_24 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_25 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0bh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_26 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0ch,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_27 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0dh,0ch,0dh,0eh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0ch,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_28 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0eh,0dh,0dh,0dh,0dh,0ch,0dh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_29 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2a DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2b DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2c DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2d DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2e DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_pikamini_line_2f DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh

;#afficher un sprite#
;
;cx position x
;dx position y
;si adresse des pixels
;
;call show_sprite

show_sprite PROC
    push cx ;sprite_x
    push dx ;sprite_y
    mov di, sp
    
    mov ax, w.[si-4] ;sprite_w
    mul w.[si-2] ;sprite_h
    mov bx, ax
                      
    mov dx, [di+0] ;sprite_y
    add dx, w.[si-2] ;sprite_h
    
    rows:     
        dec dx        
        
        mov cx, w.[di+2] ;sprite_x     
        add cx, w.[si-4] ;sprite_w
        columns:
            dec cx   
            dec bx
            
            mov al, b.[si+bx] ;pixel_color
            mov ah, 0ch ;put pixel
            int 10h  
            
            cmp cx, w.[di+2] ;sprite_x
            ja columns
     
        cmp dx, w.[di+0] ;sprite_y
        ja rows 
        
    pop dx
    pop cx
    
    ret
show_sprite ENDP



END