assume cs:codesg

datasg segment
	db 'welcome to masm!'
	db 02h,24h,71h
	;������ɫ
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
	;�� 12-14�� ��ʼ��ʾ���ݡ�160 *12 =1920 780h
	mov si,10h 
	;��ɫ���ڴ�ƫ�Ƶ�ַ��������1 ָ����һ���ֽ�
	
	mov cx,3 
	;����ѭ������ɫ
	
s:
	mov ah,[si]
	;��ɫ���ַ��ĺ���Ҳ���Ǹ�λ������ɫ�����λ
	push cx
	push si
	
	mov cx,16
	mov si,64
	;��64 ��֤�ַ��������м���ʾ��(160 -16(�ַ�)- 16(��ɫ)) /2 �м�λ��
	mov di,0
	
s0:
	mov al,[di]
	;��ȡ�ַ�
	mov es:[bx+si],al
	mov es:[bx+si+1],ah
	;���ַ�����ɫ���Ƶ��ڴ�
	
	add si,2
	add di,1
	
	loop s0
	
	pop si
	pop cx
	
	add si,1
	;��ɫ����
	add bx,0a0h
	;��ʾ����
	loop s
	
	

	mov ax,4c00h
	int 21h

codesg ends

end start