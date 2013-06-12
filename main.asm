; a short program to check how
; set and get pixel color works

name "pixel"

org  100h


; jump over data section:
jmp     start

; ------ data section ------

wait_time dw    0


; message de bienvenue
msg db "==== TamagoB1 ====", 0dh,0ah
	db "Ce projet ne peut tourner dans l'emulateur", 0dh,0ah
	db "car il requiert une vitesse d'execution que celui-ci ne peut fournir", 0dh,0ah, 0ah
	db "Si vous souhaitez faire tourner ce jeu,", 0dh,0ah
	db "utilisez le fichier run.bat fourni avec le jeu.", 0dh,0ah, 0ah
	db "vous pouvez controler le pet avec les fleches <^v>", 0dh,0ah		
	db "appuyez sur Esc pour quitter.", 0dh,0ah
	db "====================", 0dh,0ah, 0ah
	db "appuyez sur n'importe quelle touche pour demarrer...$"

; ------ code section ------

start:

; print welcome message:
mov dx, offset msg
mov ah, 9 
int 21h


;on attend une touche
wait_for_key_press:
mov ah, 01h
int 16h
jz  wait_for_key_press

mov ah, 00h
int 16h ;on récupère la touche

cmp al, 1bh    ;touche échap ?
jne game_init  ;on lance le jeu

int 20h ;on quitte le jeu
       

game_init:
; hide text cursor:
;mov     ah, 1
;mov     ch, 2bh
;mov     cl, 0bh
;int     10h      

; ------ passage en mode pixel ------

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
mov bx, 0   ; disable blinking. 
int 10h     ; set it!  


lea si, sprite_pikamini
mov sprite_pet, si
mov sprite_pet_position_x, 10
mov sprite_pet_position_y, 10

call show_init_game

jmp game_loop

;========= variables de fonctionnement DEBUT ============= 
 
sprite_pet DW ?
sprite_pet_position_x DW ?
sprite_pet_position_y DW ?

sprite_happyness_position_x equ 120
sprite_happyness_position_y equ 10
sprite_hunger_position_x equ 120
sprite_hunger_position_y equ 40   
sprite_discipline_position_x equ 120
sprite_discipline_position_y equ 70

sprite_buttons_position_x equ 50
sprite_buttons_position_y equ 100


pet_happyness DW 1
pet_hunger DW 1
pet_discipline DW 1 


reprimand_is_justified DW 0


;========= variables de fonctionnement  FIN  =============

game_loop: 

check_for_key:

; === check for player commands:
mov     ah, 01h
int     16h
jz      no_key

call handle_events

no_key:

; === wait a few moments here:
; get number of clock ticks
; (about 18 per second)
; since midnight into cx:dx
;mov     ah, 00h
;int     1ah
;cmp     dx, wait_time
;jb      check_for_key
;add     dx, 4
;mov     wait_time, dx


; === eternal game loop:
jmp     game_loop

ret


;#gérer les events#
;
;call handle_events
handle_events PROC    
    
    mov ah, 00h
    int 16h
        
    cmp al, 1bh    ; touche échap
    je  key_esc 
                                   
    cmp ah, 4Bh    ; fleche gauche
    je  key_left
        
    cmp ah, 4Dh    ; fleche droite
    je  key_right   
        
    cmp ah, 48h    ; fleche haut
    je  key_up
        
    cmp ah, 50h    ; fleche bas
    je  key_down
    
    ret 
    
;gestion en fonction de la touche :    
    
    key_esc:  
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_esc ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
        int 20h ;on arrête le jeu
    
    key_left:
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_left ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
        call feed_the_pet_with_snack
        
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
           
    ret
    
    key_right:
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_right ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
        call feed_the_pet_with_meal
        
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
              
    ret
    
    key_up:
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_up ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
    
        call play_with_the_pet
        
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite

    ret
                                
    
    key_down:
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_down ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
        call reprimand_the_pet
        
        mov cx, sprite_buttons_position_x ;position x du sprite
        mov dx, sprite_buttons_position_y ;position y du sprite
        lea si, sprite_buttons_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite

    ret 
  
handle_events ENDP


feed_the_pet_with_snack PROC
    add pet_hunger, 1
    add pet_happyness, 1
    call update_pet_states_sprites
       
    ret       
feed_the_pet_with_snack ENDP


feed_the_pet_with_meal PROC
    add pet_hunger, 1
    call update_pet_states_sprites
       
    ret
feed_the_pet_with_meal ENDP


play_with_the_pet PROC
    sub pet_hunger, 1
    add pet_happyness, 1
    call update_pet_states_sprites
       
    ret
play_with_the_pet ENDP


reprimand_the_pet PROC
    
    ret
reprimand_the_pet ENDP

;#mettre à jour les sprites d'état du pet#
;
;call update_pet_states_sprites
update_pet_states_sprites PROC
    
    ;====happyness====
    
    update_pet_states_sprites_happyness:
        cmp pet_happyness, 0
        je update_pet_states_sprites_happyness_bad
        cmp pet_happyness, 1
        je update_pet_states_sprites_happyness_normal
        cmp pet_happyness, 2
        je update_pet_states_sprites_happyness_good
        
    ret
    
    update_pet_states_sprites_happyness_bad:
        mov cx, sprite_happyness_position_x ;position x du sprite
        mov dx, sprite_happyness_position_y ;position y du sprite
        lea si, sprite_happyness_bad ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_hunger
        
    update_pet_states_sprites_happyness_normal:
        mov cx, sprite_happyness_position_x ;position x du sprite
        mov dx, sprite_happyness_position_y ;position y du sprite
        lea si, sprite_happyness_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_hunger 
        
    update_pet_states_sprites_happyness_good:
        mov cx, sprite_happyness_position_x ;position x du sprite
        mov dx, sprite_happyness_position_y ;position y du sprite
        lea si, sprite_happyness_good ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_hunger
        
    ;====hunger====
    
    update_pet_states_sprites_hunger:
        cmp pet_hunger, 0
        je update_pet_states_sprites_hunger_bad
        cmp pet_hunger, 1
        je update_pet_states_sprites_hunger_normal
        cmp pet_hunger, 2
        je update_pet_states_sprites_hunger_good
        
    ret
    
    update_pet_states_sprites_hunger_bad:
        mov cx, sprite_hunger_position_x ;position x du sprite
        mov dx, sprite_hunger_position_y ;position y du sprite
        lea si, sprite_hunger_bad ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_discipline
        
    update_pet_states_sprites_hunger_normal:
        mov cx, sprite_hunger_position_x ;position x du sprite
        mov dx, sprite_hunger_position_y ;position y du sprite
        lea si, sprite_hunger_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_discipline 
        
    update_pet_states_sprites_hunger_good:
        mov cx, sprite_hunger_position_x ;position x du sprite
        mov dx, sprite_hunger_position_y ;position y du sprite
        lea si, sprite_hunger_good ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_discipline
        
    ;====discipline====
    
    update_pet_states_sprites_discipline:
        cmp pet_discipline, 0
        je update_pet_states_sprites_discipline_bad
        cmp pet_discipline, 1
        je update_pet_states_sprites_discipline_normal
        cmp pet_discipline, 2
        je update_pet_states_sprites_discipline_good
        
    ret
    
    update_pet_states_sprites_discipline_bad:
        mov cx, sprite_discipline_position_x ;position x du sprite
        mov dx, sprite_discipline_position_y ;position y du sprite
        lea si, sprite_discipline_bad ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    ret
        
    update_pet_states_sprites_discipline_normal:
        mov cx, sprite_discipline_position_x ;position x du sprite
        mov dx, sprite_discipline_position_y ;position y du sprite
        lea si, sprite_discipline_normal ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    ret 
        
    update_pet_states_sprites_discipline_good:
        mov cx, sprite_discipline_position_x ;position x du sprite
        mov dx, sprite_discipline_position_y ;position y du sprite
        lea si, sprite_discipline_good ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    ret 
update_pet_states_sprites ENDP    


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


include tools/buttons_normal.txt
include tools/buttons_left.txt
include tools/buttons_right.txt
include tools/buttons_up.txt
include tools/buttons_down.txt   
include tools/buttons_esc.txt
                       


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
    
    show_sprite_rows:     
        dec dx        
        
        mov cx, w.[di+2] ;sprite_x     
        add cx, w.[si-4] ;sprite_w
        show_sprite_columns:
            dec cx   
            dec bx
            
            mov al, b.[si+bx] ;pixel_color
            mov ah, 0ch ;put pixel
            int 10h  
            
            cmp cx, w.[di+2] ;sprite_x
            ja show_sprite_columns
     
        cmp dx, w.[di+0] ;sprite_y
        ja show_sprite_rows 
        
    pop dx
    pop cx
    
    ret
show_sprite ENDP

;#effacer un sprite#
;
;cx position x
;dx position y
;si adresse des pixels
;
;call clear_sprite
clear_sprite PROC
    push cx ;sprite_x
    push dx ;sprite_y
    mov di, sp
                      
    mov dx, [di+0] ;sprite_y
    add dx, w.[si-2] ;sprite_h
    
    clear_sprite_rows:     
        dec dx        
        
        mov cx, w.[di+2] ;sprite_x     
        add cx, w.[si-4] ;sprite_w
        clear_sprite_columns:
            dec cx
            
            mov al, 00h ;pixel_color
            mov ah, 0ch ;put pixel
            int 10h  
            
            cmp cx, w.[di+2] ;sprite_x
            ja clear_sprite_columns
     
        cmp dx, w.[di+0] ;sprite_y
        ja clear_sprite_rows 
        
    pop dx
    pop cx
    
    ret
clear_sprite ENDP

;#effacer l'écran#
;
;call clear_screen
clear_screen PROC
    mov dx, 199
    
    clear_screen_rows:     
        dec dx        
        
        mov cx, 319
        
        clear_screen_columns:
            dec cx 
            
            mov al, 00h ;pixel_color
            mov ah, 0ch ;put pixel
            int 10h  
            
            cmp cx, 0
            ja clear_screen_columns
     
        cmp dx, 0
        ja clear_screen_rows
    
    ret
clear_screen ENDP



show_init_game PROC
        
    mov cx, 1
    mov dx, 1
    lea si, sprite_colors
    call show_sprite
    
    mov cx, sprite_pet_position_x ;position x du sprite
    mov dx, sprite_pet_position_y ;position y du sprite
    mov si, sprite_pet ;adresse du sprite
    call show_sprite ;appel de la procedure qui affiche le sprite        
    
    mov cx, sprite_happyness_position_x ;position x du sprite
    mov dx, sprite_happyness_position_y ;position y du sprite
    lea si, sprite_happyness_normal ;adresse du sprite
    call show_sprite ;appel de la procedure qui affiche le sprite
    
    mov cx, sprite_hunger_position_x ;position x du sprite
    mov dx, sprite_hunger_position_y ;position y du sprite
    lea si, sprite_hunger_normal ;adresse du sprite
    call show_sprite ;appel de la procedure qui affiche le sprite
    
    mov cx, sprite_discipline_position_x ;position x du sprite
    mov dx, sprite_discipline_position_y ;position y du sprite
    lea si, sprite_discipline_normal ;adresse du sprite
    call show_sprite ;appel de la procedure qui affiche le sprite
    
    mov cx, sprite_buttons_position_x ;position x du sprite
    mov dx, sprite_buttons_position_y ;position y du sprite
    lea si, sprite_buttons_normal ;adresse du sprite
    call show_sprite ;appel de la procedure qui affiche le sprite
    
    ret
show_init_game ENDP

END