name "Example 1"
org 100h

mov AX, 010F0h
mov BX, 0C0B8H
mov CX, 00A10h
mov DX, 0DDFFh

add BX,DX
adc AX,CX

; add your code here

ret




