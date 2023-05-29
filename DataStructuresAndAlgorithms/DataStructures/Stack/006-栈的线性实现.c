//
//  006-栈的线性实现.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/29.
//

#include "Stack.h"

// 1、构建一个空栈S
Status InitStack(SqStack *S) {
	S->top = -1;
	return SUCCESS;
}

// 2、将栈置空
Status ClearStack(SqStack *S) {
	//疑问: 将栈置空,需要将顺序栈的元素都清空吗?
	//不需要,只需要修改top标签就可以了.
	S->top = -1;
	return SUCCESS;
}

// 3、判断顺序栈是否为空
Status StackEmpty(SqStack S) {
	if (S.top == -1)
		return TRUE;
	else
		return FALSE;
}

// 4、返回栈的长度
int StackLength(SqStack S) {
	return S.top + 1;
}

// 5、获取栈顶（不代表出栈）
Status GetTop(SqStack S, ElemType *e) {
	if (S.top == -1)
		return ERROR;
	else
		// C语言 Tips2：
		// .语法： 为结构体变量的时候使用
		// ->语法：为指针的时候使用
		*e = S.data[S.top];
   
	return SUCCESS;
}

// 6、压栈，插入元素e为新栈顶元素
Status PushData(SqStack *S, ElemType e) {
	
	// 栈已满
	if (S->top == MAXSIZE - 1) {
		return ERROR;
	}
	
	// 栈顶指针+1;
	S->top ++;
	
	// 将新插入的元素赋值给栈顶空间
	S->data[S->top] = e;
	
	return SUCCESS;
}

// 7、出栈，删除S栈顶元素，并且用e带回
Status Pop(SqStack *S, ElemType *e) {
   
	//空栈,则返回error;
	if (S->top == -1) {
		return ERROR;
	}
	
	//将要删除的栈顶元素赋值给e
	*e = S->data[S->top];
	
	//栈顶指针--;
	S->top--;
	
	return SUCCESS;
}

// 8、从栈底到栈顶依次对栈中的每个元素打印
Status StackTraverse(SqStack S) {
	
	if (S.top == -1) return ERROR;
	
	int i = 0;
	printf("此栈中所有元素: ");
	while (i <= S.top) {
		// C语言 Tips3：
		// i++: 先用后加
		// ++i: 先加后用
		printf("%d ", S.data[i++]);
	}
	printf("\n");
	return SUCCESS;
}

void run006(void) {
	
	printf("顺序栈的表示与实现!\n");
	
	SqStack S;
	int e;
	
	if (InitStack(&S) == SUCCESS) {
		for (int j = 1 ; j < 10; j++) {
			PushData(&S, j);
		}
	}
	
	printf("顺序栈中元素为:\n");
	StackTraverse(S);
	
	Pop(&S, &e);
	printf("弹出栈顶元素为: %d\n",e);
	
	StackTraverse(S);
	printf("是否为空栈: %d\n", StackEmpty(S));
	
	GetTop(S, &e);
	printf("栈顶元素: %d\n栈长度:%d\n", e, StackLength(S));
	
	ClearStack(&S);
	printf("是否已经清空栈 %d, 栈长度为: %d\n", StackEmpty(S), StackLength(S));
}
