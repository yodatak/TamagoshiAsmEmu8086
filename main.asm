; a short program to check how
; set and get pixel color works

name "pixel"

org  100h

mov ah, 0   ; set display mode function.
mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
int 10h     ; set it!



;0      0000      black
;1      0001      blue
;2      0010      green
;3      0011      cyan
;4      0100      red
;5      0101      magenta
;6      0110      brown
;7      0111      light gray
;8      1000      dark gray
;9      1001      light blue
;A      1010      light green
;B      1011      light cyan
;C      1100      light red
;D      1101      light magenta
;E      1110      yellow
;F      1111      white

jmp code
cadre:

; dimensions of the rectangle:
; width: 10 pixels
; height: 5 pixels

w equ 319
h equ 199


code:
; draw upper line:

    mov cx, 0+w  ; column
    mov dx, 0     ; row
    mov al, 1101b     ; white
u1: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    jae u1
 

 
; draw left line:

    mov cx, 0    ; column
    mov dx, 0+h   ; row
    mov al, 1101b     ; white
u3: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 1
    ja u3 
    
    
; draw right line:

    mov cx, 0+w  ; column
    mov dx, 0+h   ; row
    mov al, 1101b     ; white
u4: mov ah, 0ch    ; put pixel
    int 10h
    
    dec dx
    cmp dx, 1
    ja u4     
	
; draw bottom line:

    mov cx, 0+w  ; column
    mov dx, 0+h   ; row
    mov al, 1101b     ; white
u2: mov ah, 0ch    ; put pixel
    int 10h
    
    dec cx
    cmp cx, 1
    ja u2

;ICI ON fait les pixels
pixel:

mov cx, 10  ; column
mov dx, 20  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 9  ; column
mov dx, 19  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

mov cx, 8  ; column
mov dx, 18  ; row
mov al, 1101b  ; red
mov ah, 0ch ; put pixel
int 10h

;jmp     game_loop


; pause the screen for dos compatibility:

;wait for keypress
  mov ah,00
  int 16h			


  

	
ret

