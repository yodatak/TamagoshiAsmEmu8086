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
;cx  colonne
;dx  ligne
;               
;al  couleur
;0   black
;1   blue
;2   green
;3   cyan
;4   red
;5   magenta
;6   brown
;7   light gray
;8   dark gray
;9   light blue
;A   light green
;B   light cyan
;C   light red
;D   light magenta
;E   yellow      
;F   white
;
;mov ah, 0ch
;int 10h                      

sprite_pikamini_w DW 8
sprite_pikamini_h DW 3
sprite_pikamini   DB 04h,04h,04h,04h,04h,04h,04h,04h, 04h,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh,04h, 04h,0Fh,0Fh,0Fh,0Fh,0Fh,0Fh,04h

show_sprite_spriteptr DW ?

show_sprite PROC
    
    mov bx, si
    sub bx, 04h
    mov show_sprite_spriteptr, bx
    
      
    mov ax, [si-4]
    mul [si-2]
    mov bx, ax
    
    push cx
    push dx              
    add dx, [si-2]
    
    show_sprite_loop1:     
        dec dx
        
        pop cx ;sprite_x
        push cx     
        add cx, sprite_w
        show_sprite_loop2:
            dec cx   
            dec bx
            
            mov al, show_sprite_spriteptr[bx]  
            mov ah, 0ch ;put pixel
            int 10h  
            
            
            cmp cx, sprite_x
            ja show_sprite_loop2
        
        pop ax ;sprite_y  
        cmp dx, ax
        ja show_sprite_loop1
    
    ret
show_sprite ENDP             

END