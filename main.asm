; a short program to check how
; set and get pixel color works

name "pixel"

org  100h


; jump over data section:
jmp     start

; ------ data section ------

s_size  equ     7

; the snake coordinates
; (from head to tail)
; low byte is left, high byte
; is top - [top, left]
snake dw s_size dup(0)

tail    dw      ?

; direction constants
;          (bios key codes):
left    equ     4bh
right   equ     4dh
up      equ     48h
down    equ     50h

; current snake direction:
cur_dir db      right

wait_time dw    0


; welcome message
msg 	db "==== Allez Viens ====", 0dh,0ah
	db "On Aime faire de la merde", 0dh,0ah
	db "This project is not designed to run on the emulator", 0dh,0ah
	db "because it requires relatively fast video card and cpu.", 0dh,0ah, 0ah
	
	db "if you want to see how this game really works,", 0dh,0ah
	db "run it on a dosbox (click external->run from the menu).", 0dh,0ah, 0ah
	
	db "you can control the pockemon using arrow keys", 0dh,0ah	
	db "all .", 0dh,0ah, 0ah
	
	db "press esc to exit.", 0dh,0ah
	db "====================", 0dh,0ah, 0ah
	db "press any key to start...$"

; ------ code section ------

start:

; print welcome message:
mov dx, offset msg
mov ah, 9 
int 21h


; wait for any key:


mov     ah, 00h
int     16h
je      draw

cmp     al, 1bh    ; esc - key?
je      stop_game  ;  go to menu
       
       
    





draw:
; hide text cursor:
mov     ah, 1
mov     ch, 2bh
mov     cl, 0bh
int     10h      

; ------ Pixel section ------

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
mov bx, 0   ; disable blinking. 
int 10h     ; set it!  

game_init:

lea si, sprite_happyness_normal
mov sprite_happyness, si 

lea si, sprite_hunger_normal
mov sprite_hunger, si       

lea si, sprite_discipline_normal
mov sprite_discipline, si

jmp game_loop

sprite_happyness DW ?
sprite_hunger DW ?
sprite_discipline DW ?

game_loop: 

mov cx, 1
mov dx, 1
lea si, sprite_colors
call show_sprite

mov cx, 10 ;position x du sprite
mov dx, 20 ;position y du sprite
lea si, sprite_pikamini ;adresse du sprite
call show_sprite ;appel de la procedure qui affiche le sprite        

mov cx, 120 ;position x du sprite
mov dx, 10 ;position y du sprite
mov si, sprite_happyness ;adresse du sprite
call show_sprite ;appel de la procedure qui affiche le sprite

mov cx, 120 ;position x du sprite
mov dx, 40 ;position y du sprite
mov si, sprite_hunger ;adresse du sprite
call show_sprite ;appel de la procedure qui affiche le sprite

mov cx, 120 ;position x du sprite
mov dx, 70 ;position y du sprite
mov si, sprite_discipline ;adresse du sprite
call show_sprite ;appel de la procedure qui affiche le sprite


check_for_key:

; === check for player commands:
mov     ah, 01h
int     16h
jz      no_key

mov     ah, 00h
int     16h

cmp     al, 1bh    ; esc - key?
je      start  ;  go to menu

;mov     cur_dir, ah






no_key:



; === wait a few moments here:
; get number of clock ticks
; (about 18 per second)
; since midnight into cx:dx
mov     ah, 00h
int     1ah
cmp     dx, wait_time
jb      check_for_key
add     dx, 4
mov     wait_time, dx


; === eternal game loop:
jmp     game_loop

stop_game:

; show cursor back:
mov     ah, 1
mov     ch, 0bh
mov     cl, 0bh
int     10h

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

sprite_colors_w DW 10h
sprite_colors_h DW 01h
sprite_colors DB 00h,01h,02h,03h,04h,05h,06h,07h,08h,09h,0ah,0bh,0ch,0dh,0eh,0fh


sprite_oeuf_w DW 020h
sprite_oeuf_h DW 020h
sprite_oeuf DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_2 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_3 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,02h,02h,02h,02h,02h,02h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_4 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,02h,02h,00h,00h,00h,0fh,00h,00h,02h,02h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_5 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,00h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,02h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_6 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,02h,00h,00h,00h,00h,06h,00h,00h,00h,0fh,00h,00h,00h,02h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_7 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,00h,00h,06h,00h,00h,00h,00h,00h,00h,00h,06h,00h,00h,00h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_8 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,01h,04h,06h,06h,05h,05h,05h,05h,05h,05h,05h,06h,06h,06h,04h,01h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_9 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,05h,06h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,04h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_a DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,05h,00h,00h,00h,0fh,00h,0fh,00h,00h,00h,0fh,00h,0fh,00h,00h,04h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_b DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,01h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,00h,00h,0fh,00h,00h,01h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_c DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,04h,00h,00h,0fh,0fh,0fh,0fh,00h,00h,0fh,0fh,0fh,0fh,00h,00h,05h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_d DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,05h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,06h,04h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_e DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,00h,01h,05h,05h,05h,05h,05h,05h,04h,04h,04h,04h,05h,05h,05h,03h,00h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_f DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,00h,00h,00h,06h,00h,00h,00h,00h,00h,00h,00h,06h,00h,00h,00h,00h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_10 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,00h,00h,00h,00h,0fh,00h,06h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_11 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,00h,06h,00h,00h,00h,0fh,00h,00h,00h,00h,00h,06h,00h,0fh,00h,00h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_12 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,00h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,00h,00h,00h,00h,0fh,00h,01h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_13 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,01h,0fh,00h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,00h,00h,00h,00h,0fh,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_14 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,00h,0fh,00h,00h,06h,00h,00h,00h,0fh,00h,00h,00h,00h,00h,00h,00h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_15 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,02h,00h,0fh,00h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,00h,00h,01h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_16 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,00h,00h,0fh,00h,00h,00h,00h,00h,00h,0fh,00h,00h,00h,00h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_17 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,02h,02h,00h,00h,0fh,00h,00h,06h,00h,00h,00h,0fh,00h,00h,02h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_18 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,02h,00h,00h,0fh,00h,00h,00h,00h,00h,00h,01h,02h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_19 DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,02h,01h,00h,0fh,00h,00h,00h,00h,01h,03h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1a DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,03h,02h,02h,02h,01h,02h,02h,02h,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1b DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1c DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1d DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1e DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
sprite_oeuf_line_1f DB 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh

include tools/pikamini.txt


include tools/happyness_good.txt
include tools/happyness_normal.txt
include tools/happyness_bad.txt

include tools/hunger_good.txt
include tools/hunger_normal.txt
include tools/hunger_bad.txt

include tools/discipline_good.txt
include tools/discipline_normal.txt
include tools/discipline_bad.txt




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
    mov bx, ax ;nombre total de pixels
                      
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