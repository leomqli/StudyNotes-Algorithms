//
//  007-栈的链式实现.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/29.
//

#include "007-栈的链式实现.h"

/// 栈里节点
typedef struct StackNode {
	ElemType data;
	struct StackNode *next;
} StackNode, *LinkStackPtr;

/// 链式栈结构
typedef struct {
	LinkStackPtr top;
	int count;
} LinkStack;

/// 7.1、构造一个空栈S
Status InitLinkStack(LinkStack *S) {
	// 创建好后
	S->top = (LinkStackPtr)malloc(sizeof(StackNode));
	if (S->top == NULL) return ERROR;
	
	// 不存储数据
	S->top = NULL;
	S->count = 0;
	
	return SUCCESS;
}

/// 7.2、把链栈S置为空栈
Status ClearLinkStack(LinkStack *S) {
	LinkStackPtr p,q;
	p = S->top;
	while (p) {
		q = p;
		p = p->next;
		free(q);
	}
	S->count = 0;
	return SUCCESS;
}

/// 7.3、若栈S为空栈,则返回TRUE，否则返回FALSE
Status LinkStackEmpty(LinkStack S) {
	if (S.count == 0)
		return TRUE;
	else
		return FALSE;
}

/// 7.4、返回S的元素个数，即栈的长度
int LinkStackLength(LinkStack S) {
	return S.count;
}

/// 7.5、若链栈S不为空，则用e返回栈顶元素，并返回OK，否则返回ERROR
Status GetLinkStackTop(LinkStack S, ElemType *e) {
	if (S.top == NULL)
		return ERROR;
	else
		*e = S.top->data;
	return SUCCESS;
}

/// 7.6、插入元素e到链栈S (成为栈顶新元素)
Status LinkStackPush(LinkStack *S, ElemType e) {
	//创建新结点temp
	LinkStackPtr temp = (LinkStackPtr)malloc(sizeof(StackNode));
	if (!temp) return ERROR;
	
	//赋值
	temp->data = e;
	//把当前的栈顶元素赋值给新结点的直接后继, 参考图例第①步骤;
	temp->next = S->top;
	
	//将新结点temp 赋值给栈顶指针,参考图例第②步骤;
	S->top = temp;
	S->count++;
	return SUCCESS;
}

/// 7.7、若栈不为空，则删除S的栈顶元素,用e返回其值。并返回OK,否则返回ERROR
Status LinkStackPop(LinkStack *S, ElemType *e) {
	if (LinkStackEmpty(*S)) return ERROR;

	LinkStackPtr p;
		
	// 将栈顶元素赋值给*e
	*e = S->top->data;
	// 将栈顶结点赋值给p，参考图例①
	p = S->top;

	// 使得栈顶指针下移一位，指向后一结点. 参考图例②
	S->top = S->top->next;
	// 个数--
	S->count--;

	// 释放p
	free(p);
	
	return SUCCESS;
}

/// 7.8、遍历链栈
Status LinkStackTraverse(LinkStack S) {
	LinkStackPtr p;
	p = S.top;
	while (p) {
		printf("%d ", p->data);
		p = p->next;
	}
	printf("\n");
	return SUCCESS;
}

void run007(void) {
	
	printf("链式栈定义与实现\n");
	
	int j;
	LinkStack s;
	
	int e;
	
	if (InitLinkStack(&s) == SUCCESS) {
		for (j = 1; j <= 10; j++)
			LinkStackPush(&s, j);
	}
	
	printf("栈中元素依次为：");
	LinkStackTraverse(s);
	
	LinkStackPop(&s,&e);
	printf("弹出的栈顶元素 e = %d\n",e);
	
	LinkStackTraverse(s);
	printf("栈空否：%d(1:空 0:否)\n", LinkStackEmpty(s));
	
	GetLinkStackTop(s,&e);
	printf("栈顶元素 e = %d 栈的长度为%d\n", e, LinkStackLength(s));
	
	ClearLinkStack(&s);
	printf("清空栈后，栈空否：%d(1:空 0:否)\n", LinkStackEmpty(s));
}
