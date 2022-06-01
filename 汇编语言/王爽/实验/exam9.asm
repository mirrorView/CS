assume cs:codesg

datasg segment
	db 'welcome to masm!'
	db 02h,24h,71h
	;背景颜色
datasg ends;

stack segment
	dw 8 dup(0)
stack ends 


codesg segment
	
start:
	
	mov ax,datasg
	mov ds,ax
	
	mov ax,0b800h
	mov es,ax
	
	mov ax,stack
	mov ss,ax
	mov sp,10h
	
	mov bx,780h
	;从 12-14行 开始显示内容。160 *12 =1920 780h
	mov si,10h 
	;颜色的内存偏移地址，增量是1 指向下一个字节
	
	mov cx,3 
	;三个循环的颜色
	
s:
	mov ah,[si]
	;颜色在字符的后面也就是高位，把颜色放入高位
	push cx
	push si
	
	mov cx,16
	mov si,64
	;用64 保证字符可以在中间显示，(160 -16(字符)- 16(颜色)) /2 中间位置
	mov di,0
	
s0:
	mov al,[di]
	;获取字符
	mov es:[bx+si],al
	mov es:[bx+si+1],ah
	;把字符和颜色复制到内存
	
	add si,2
	add di,1
	
	loop s0
	
	pop si
	pop cx
	
	add si,1
	;颜色换行
	add bx,0a0h
	;显示换行
	loop s
	
	

	mov ax,4c00h
	int 21h

codesg ends

end start