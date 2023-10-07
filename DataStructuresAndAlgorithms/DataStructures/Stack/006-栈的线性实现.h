//
//  006-栈的线性实现.h
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/29.
//

#ifndef _06________h
#define _06________h

#include "BaseDefine.h"

/// 顺序栈结构
typedef struct {
	ElemType data[MAXSIZE];
	/* 用于栈顶指针 */
	int top;
} SqStack;

// 6.1、构建一个空栈S
Status InitStack(SqStack *S);

// 6.2、将栈置空
Status ClearStack(SqStack *S);

// 6.3、判断顺序栈是否为空
Status StackEmpty(SqStack S);

// 6.4、返回栈的长度
int StackLength(SqStack S);

// 6.5、获取栈顶（不代表出栈）
Status GetSqStackTop(SqStack S, ElemType *e);

// 6.6、压栈，插入元素e为新栈顶元素
Status SqStackPush(SqStack *S, ElemType e);

// 6.7、出栈，删除S栈顶元素，并且用e带回
Status SqStackPop(SqStack *S, ElemType *e);

// 6.8、从栈底到栈顶依次对栈中的每个元素打印
Status StackTraverse(SqStack S);

void run006(void);

#endif /* _06________h */
