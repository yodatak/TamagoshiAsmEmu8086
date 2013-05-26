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

sprite_pikamini_w DW 8
sprite_pikamini_h DW 3
sprite_pikamini   DB 04h,04h,04h,04h,04h,04h,04h,04h, 04h,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh,04h, 04h,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh,04h

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
                      
    mov dx, [di+2] ;sprite_y
    add dx, w.[si-2] ;sprite_h
    
    rows:     
        dec dx        
        
        mov cx, w.[di+4] ;sprite_x     
        add cx, w.[si-4] ;sprite_w
        columns:
            dec cx   
            dec bx
            
            mov al, b.[si+bx] ;pixel_color
            mov ah, 0ch ;put pixel
            int 10h  
            
            cmp cx, w.[di+4] ;sprite_x
            ja columns
     
        cmp dx, w.[di+2] ;sprite_y
        ja rows 
        
    pop dx
    pop cx
    
    ret
show_sprite ENDP



END