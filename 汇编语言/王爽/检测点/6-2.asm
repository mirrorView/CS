;����ĳ���ʵ���������ڴ�0:0 ~ 0:15 ��Ԫ�е����ݸ�д�����е����ݣ����ݵĴ�����ջ�����С�
assume cs:codesg

codesg segment
	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
	dw 0,0,0,0,0,0,0,0,0,0
	;---ip���24h
	
start:
	mov ax,cs
	mov ss,ax
	mov sp,24h
	;����д���ˣ��տ�ʼд��10h ��push sp-2 ����ջ���� ���ݶε����ݡ� ����push ����sp = sp-2 ���������sp ��������Ϊ24h
	
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