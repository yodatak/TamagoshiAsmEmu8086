; a short program to check how
; set and get pixel color works

name "pixel"

org  100h


; jump over data section:
jmp     start

; ------ data section ------

wait_time_hm DW 0
wait_time_sc DW 0


; message de bienvenue
msg DB "==== TamagoB1 ====", 0dh,0ah
	DB "Ce projet ne peut tourner dans l'emulateur", 0dh,0ah
	DB "car il requiert une vitesse d'execution que celui-ci ne peut fournir", 0dh,0ah, 0ah
	DB "Si vous souhaitez faire tourner ce jeu,", 0dh,0ah
	DB "utilisez le fichier run.bat fourni avec le jeu.", 0dh,0ah, 0ah
	DB "vous pouvez controler le pet avec les fleches <^v>", 0dh,0ah		
	DB "^   JOUER: deviner si le pet va aller a gauche < ou a droite >", 0dh,0ah
	DB "v   REPRIMANDER", 0dh,0ah
	DB "<   DONNER UN SNACK", 0dh,0ah
	DB ">   DONNER UN REPAS", 0dh,0ah
	DB "Esc QUITTER", 0dh,0ah
	DB "====================", 0dh,0ah, 0ah
	DB "appuyez sur n'importe quelle touche pour demarrer...$"

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
int 16h ;on r�cup�re la touche

cmp al, 1bh    ;touche �chap ?
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
mov sprite_pet_position_x, 40
mov sprite_pet_position_y, 40

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


pet_happyness DW 2
pet_hunger DW 2
pet_discipline DW 2 


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


;#g�rer les events#
;
;call handle_events
handle_events PROC    
    
    mov ah, 00h
    int 16h
        
    cmp al, 1bh    ; touche �chap
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
        
        int 20h ;on arr�te le jeu
    
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
    sub pet_discipline, 1
    call update_pet_states_sprites
    
    mov ah, 2Ch
    int 21h
    mov wait_time_hm, cx
    mov wait_time_sc, dx
    
    add wait_time_sc, 0100h
    
    feed_the_pet_with_snack_wait:
        mov ah, 2Ch
        int 21h
        
        cmp cx, wait_time_hm
        jb  feed_the_pet_with_snack_wait  

        cmp dx, wait_time_sc   
        jb  feed_the_pet_with_snack_wait    
        
    ret       
feed_the_pet_with_snack ENDP


feed_the_pet_with_meal PROC
    add pet_hunger, 1
    call update_pet_states_sprites
    
    mov ah, 2Ch
    int 21h
    mov wait_time_hm, cx
    mov wait_time_sc, dx
    
    add wait_time_sc, 0100h
    
    feed_the_pet_with_meal_wait:
        mov ah, 2Ch
        int 21h
        
        cmp cx, wait_time_hm
        jb  feed_the_pet_with_meal_wait  

        cmp dx, wait_time_sc   
        jb  feed_the_pet_with_meal_wait
       
    ret
feed_the_pet_with_meal ENDP


play_with_the_pet_win_key DB ?
play_with_the_pet_loose_key DB ?
play_with_the_pet_win_move DW ?

play_with_the_pet PROC
    mov cx, sprite_pet_position_x ;position x du sprite
    mov dx, sprite_pet_position_y ;position y du sprite
    mov si, sprite_pet ;adresse du sprite
    call clear_sprite ;appel de la procedure qui efface le sprite
    
    mov sprite_pet_position_x, 40 ;on remet le pet au milieu
    
    mov cx, sprite_pet_position_x ;position x du sprite
    mov dx, sprite_pet_position_y ;position y du sprite
    mov si, sprite_pet ;adresse du sprite
    call show_sprite ;appel de la procedure qui affiche le sprite
    
    mov ah, 2Ch
    int 21h
    
    test dl, 1 ;teste si le centi�me de seconde est impair
    jz  play_with_the_pet_set_win_key_to_right
    
    play_with_the_pet_set_win_key_to_left:
        mov play_with_the_pet_win_key, 4Bh ;fl�che gauche
        mov play_with_the_pet_loose_key, 4Dh ;fl�che droite
        mov play_with_the_pet_win_move, -10    
    
    jmp play_with_the_pet_wait_key
    
    play_with_the_pet_set_win_key_to_right:
        mov play_with_the_pet_win_key, 4Dh ;fl�che droite
        mov play_with_the_pet_loose_key, 4Bh ;fl�che gauche
        mov play_with_the_pet_win_move, 10  
    
    play_with_the_pet_wait_key:
        mov ah, 01h
        int 16h ;teste si une touche est enfonc�e
        jz  play_with_the_pet_wait_key
    
        mov ah, 00h
        int 16h ;r�cup�re la touche enfonc�e
        
        cmp ah, play_with_the_pet_win_key
        je  play_with_the_pet_win
            
        cmp ah, play_with_the_pet_loose_key
        je  play_with_the_pet_loose
        
    jmp play_with_the_pet_wait_key
    
    play_with_the_pet_win:
        sub pet_hunger, 1
        add pet_happyness, 1
       
    jmp play_with_the_pet_move_the_pet      
    
    play_with_the_pet_loose:
        sub pet_hunger, 1             
        
    play_with_the_pet_move_the_pet:
        mov bx, 2 ;*65000�s entre chaque pixel
        mov cx, play_with_the_pet_win_move ;d�placement en x        
        call move_the_pet        
        
    call update_pet_states_sprites
        
    ret
play_with_the_pet ENDP


reprimand_the_pet PROC
    cmp reprimand_is_justified, 1
    je reprimand_the_pet_justified
    
    reprimand_the_pet_unjustified:
        mov pet_happyness, 1
        sub pet_discipline, 1
        call update_pet_states_sprites  
    
    jmp reprimand_the_pet_end   
    
    reprimand_the_pet_justified:
        mov reprimand_is_justified, 0
        
        sub pet_happyness, 1
        add pet_discipline, 1
        
    reprimand_the_pet_end:         
        call update_pet_states_sprites
    
        mov ah, 2Ch
        int 21h
        mov wait_time_hm, cx
        mov wait_time_sc, dx
        
        add wait_time_sc, 0100h
        
        feed_the_pet_with_meal_wait:
            mov ah, 2Ch
            int 21h
            
            cmp cx, wait_time_hm
            jb  feed_the_pet_with_meal_wait  
    
            cmp dx, wait_time_sc   
            jb  feed_the_pet_with_meal_wait
            
    ret    
reprimand_the_pet ENDP



;#mettre � jour les sprites d'�tat du pet#
;
;call update_pet_states_sprites
update_pet_states_sprites PROC
    
    ;====happyness====
    
    update_pet_states_sprites_happyness:
        cmp pet_happyness, 2
        je update_pet_states_sprites_happyness_normal
        jb update_pet_states_sprites_happyness_bad
        ja update_pet_states_sprites_happyness_good
        
    ret
    
    update_pet_states_sprites_happyness_bad:
        mov pet_happyness, 1
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
        mov pet_happyness, 3
        mov cx, sprite_happyness_position_x ;position x du sprite
        mov dx, sprite_happyness_position_y ;position y du sprite
        lea si, sprite_happyness_good ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_hunger
        
    ;====hunger====
    
    update_pet_states_sprites_hunger:
        cmp pet_hunger, 2
        je update_pet_states_sprites_hunger_normal
        jb update_pet_states_sprites_hunger_bad
        ja update_pet_states_sprites_hunger_good
        
    ret
    
    update_pet_states_sprites_hunger_bad:
        mov pet_hunger, 1
        
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
        mov pet_hunger, 3
        
        mov cx, sprite_hunger_position_x ;position x du sprite
        mov dx, sprite_hunger_position_y ;position y du sprite
        lea si, sprite_hunger_good ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
    jmp update_pet_states_sprites_discipline
        
    ;====discipline====
    
    update_pet_states_sprites_discipline:
        cmp pet_discipline, 2                      
        je update_pet_states_sprites_discipline_normal
        jb update_pet_states_sprites_discipline_bad
        ja update_pet_states_sprites_discipline_good
        
    ret
    
    update_pet_states_sprites_discipline_bad:
        mov pet_discipline, 1
        
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
        mov pet_discipline, 3
        
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

;#effacer l'�cran#
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


move_the_pet_wait_time DW ?

move_the_pet PROC
    mov move_the_pet_wait_time, bx
    
    add cx, sprite_pet_position_x 
    push cx
    
    move_the_pet_begin:
        mov cx, sprite_pet_position_x ;position x du sprite
        mov dx, sprite_pet_position_y ;position y du sprite
        mov si, sprite_pet ;adresse du sprite
        call clear_sprite ;appel de la procedure qui efface le sprite
        
        pop cx
        
        cmp sprite_pet_position_x, cx
        ja  move_the_pet_to_left
        
        move_the_pet_to_right:
            inc sprite_pet_position_x
        
        jmp move_the_pet_show_the_pet
        
        move_the_pet_to_left:
            dec sprite_pet_position_x
        
        move_the_pet_show_the_pet:
        
        push cx
        
        mov cx, sprite_pet_position_x ;position x du sprite
        mov dx, sprite_pet_position_y ;position y du sprite
        mov si, sprite_pet ;adresse du sprite
        call show_sprite ;appel de la procedure qui affiche le sprite
        
        pop cx 
        
        cmp cx, sprite_pet_position_x ;si l'objectif est atteint
        je move_the_pet_end
        
        push cx       
        
        mov cx, move_the_pet_wait_time
        mov dx, 0
        mov ah, 86h
        int 15h
        
    jmp move_the_pet_begin
    
    move_the_pet_end:
    
    ret        
move_the_pet ENDP
               
               
               
END