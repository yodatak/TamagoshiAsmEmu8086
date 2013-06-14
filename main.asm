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
	DB "vous pouvez controler le familier avec les fleches <^v>", 0dh,0ah		
	DB "^   JOUER: deviner si le familier va aller a gauche < ou a droite >", 0dh,0ah
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

call pokemon
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
;hide mouse cursor
;mov ax, 2
;int 33h
; ------ passage en mode pixel ------

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
mov bx, 0   ; disable blinking. 
int 10h     ; set it!  

mov ah, 2Ch      ; on recup l'heure pour l'evolution
int 21h


mov evolution_timer_hm,cx
mov evolution_timer_sc,dx
add evolution_timer_hm,1
  

lea si, sprite_pikaoeuf             ; on appele l'oeuf de pikachu
mov sprite_pet, si
mov sprite_pet_position_x, 40       ; Quel position X Y ? 
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

;Timer pour l'evolution
evolution_timer_hm DW ?  ;heure minute
evolution_timer_sc DW ?  ;seconde centieme

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
call handle_evolution

; === eternal game loop:
jmp     game_loop

ret


;#gerer les events#
;
;call handle_events
handle_events PROC    
    call bip
    
    mov ah, 00h
    int 16h
        
    cmp al, 1bh    ; touche Echap
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
        
        int 20h ;on arrete le jeu
    
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
    cmp pet_discipline, 1
    jne feed_the_pet_with_snack_he_wants_to_eat
    
    mov ah, 2Ch
    int 21h
    
    test dl, 00000011b ;teste si les centième de seconde sont à 11
    jz  feed_the_pet_with_snack_he_wants_to_eat
    
    ;si le pet refuse de manger
    mov reprimand_is_justified, 1
    
    jmp feed_the_pet_with_snack_wait
    
    feed_the_pet_with_snack_he_wants_to_eat:
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
    cmp pet_discipline, 1
    jne feed_the_pet_with_meal_he_wants_to_eat
    
    mov ah, 2Ch
    int 21h
    
    test dl, 00000011b ;teste si les centième de seconde sont à 11
    jz  feed_the_pet_with_meal_he_wants_to_eat
    
    ;si le pet refuse de manger
    mov reprimand_is_justified, 1
    
    jmp feed_the_pet_with_meal_wait
    
    feed_the_pet_with_meal_he_wants_to_eat:
        add pet_hunger, 2
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
    
    cmp pet_discipline, 1
    jne play_with_the_pet_he_wants_to_play
    
    mov ah, 2Ch
    int 21h
    
    test dl, 00000011b ;teste si les centième de seconde sont à 11
    jz  play_with_the_pet_he_wants_to_play
    
    ;si le pet refuse de jouer
    mov reprimand_is_justified, 1
    
    ret    
    
    play_with_the_pet_he_wants_to_play:
        mov ah, 2Ch
        int 21h
        
        test dl, 1 ;teste si le centième de seconde est impair
        jz  play_with_the_pet_set_win_key_to_right
    
    play_with_the_pet_set_win_key_to_left:
        mov play_with_the_pet_win_key, 4Bh ;flèche gauche
        mov play_with_the_pet_loose_key, 4Dh ;flèche droite
        mov play_with_the_pet_win_move, -10    
    
    jmp play_with_the_pet_wait_key
    
    play_with_the_pet_set_win_key_to_right:
        mov play_with_the_pet_win_key, 4Dh ;flèche droite
        mov play_with_the_pet_loose_key, 4Bh ;flèche gauche
        mov play_with_the_pet_win_move, 10  
    
    play_with_the_pet_wait_key:
        mov ah, 01h
        int 16h ;teste si une touche est enfoncée
        jz  play_with_the_pet_wait_key
    
        mov ah, 00h
        int 16h ;récupère la touche enfoncée
        
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
        mov bx, 2 ;*65000µs entre chaque pixel
        mov cx, play_with_the_pet_win_move ;déplacement en x        
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
        
        reprimand_the_pet_wait:
            mov ah, 2Ch
            int 21h
            
            cmp cx, wait_time_hm
            jb  reprimand_the_pet_wait
            ja  reprimand_the_pet_wait_end  
    
            cmp dx, wait_time_sc   
            jb  reprimand_the_pet_wait
        
        reprimand_the_pet_wait_end:
            
            
    ret    
reprimand_the_pet ENDP








handle_evolution PROC 
    
    mov ah, 2Ch
    int 21h 
    
    cmp cx, evolution_timer_hm
    jb handle_evolution_no_evolution
    ja handle_evolution_evolution_ok
    
    cmp dx, evolution_timer_sc
    jb handle_evolution_no_evolution
    
    handle_evolution_evolution_ok:
        lea si, sprite_pikaevil
        mov sprite_pet, si    
    ret
    
    handle_evolution_no_evolution:
    ret
    
handle_evolution ENDP










;#mettre à jour les sprites d'état du pet#
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

include tools/pikaoeuf.txt

include tools/pikamini.txt
include tools/pikaevil.txt



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
                       

include sound.asm

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

;#afficher un sprite#
;
;cx position x
;dx position y
;si adresse des pixels
;
;call show_inverted_sprite

show_inverted_sprite PROC
    push cx ;sprite_x
    push dx ;sprite_y
    mov di, sp
    
    mov ax, w.[si-4] ;sprite_w
    mul w.[si-2] ;sprite_h
    mov bx, ax ;nombre total de pixels
                      
    mov dx, [di+0] ;sprite_y
    add dx, w.[si-2] ;sprite_h
    
    show_inverted_sprite_rows:     
        dec dx        
        
        mov cx, w.[di+2] ;sprite_x
        sub cx, 1
        show_inverted_sprite_columns:
            inc cx   
            dec bx
            
            mov al, b.[si+bx] ;pixel_color
            mov ah, 0ch ;put pixel
            int 10h  
            
            mov ax, w.[di+2] ;sprite_x
            add ax, w.[si-4] ;sprite_h
            sub ax, 1
            cmp cx, ax
            jb show_inverted_sprite_columns
     
        cmp dx, w.[di+0] ;sprite_y
        ja show_inverted_sprite_rows 
        
    pop dx
    pop cx
    
    ret
show_inverted_sprite ENDP

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
            
            push cx
        
            mov cx, sprite_pet_position_x ;position x du sprite
            mov dx, sprite_pet_position_y ;position y du sprite
            mov si, sprite_pet ;adresse du sprite
            call show_inverted_sprite ;appel de la procedure qui affiche le sprite
            
            pop cx
        
        jmp move_the_pet_compare_target
        
        move_the_pet_to_left:
            dec sprite_pet_position_x
            
            push cx
        
            mov cx, sprite_pet_position_x ;position x du sprite
            mov dx, sprite_pet_position_y ;position y du sprite
            mov si, sprite_pet ;adresse du sprite
            call show_sprite ;appel de la procedure qui affiche le sprite
            
            pop cx
        
        move_the_pet_compare_target:            
        
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

bip PROC ;super son !              
    mov al, 0b6h
    out 43h, al
    mov al, 0c9h
    out 42h, al
    mov al, 11h
    out 42h, al
    in al, 61h 
    mov ah, al
    or al, 00000011b
    out 61h, al 
    call delay
    mov al , ah
    out 61h, al 
    delay:
    mov cx, 00h ; 000f4240h = 1,000,000
    mov dx, 4240h
    mov ah, 86h
    int 15h
    ret 
bip ENDP              
               
END