;下面的程序实现依次用内存0:0 ~ 0:15 单元中的内容改写程序中的数据，数据的传送用栈来进行。
assume cs:codesg

codesg segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
	dw 0,0,0,0,0,0,0,0,0,0
	;---ip入口24h
	
start:
	mov ax,cs
	mov ss,ax
	mov sp,24h
	;这里写错了，刚开始写的10h ，push sp-2 导致栈覆盖 数据段的数据。 由于push 是先sp = sp-2 所以这里的sp 可以设置为24h
	
	mov ax,0
	mov ds,ax
	mov bx,0
	
	mov cx,8

s:
	push [bx]
	pop  cs:[bx]
	add bx,2
	loop s
	
	mov ax,4c00h
	int 21h
	
codesg ends

end start