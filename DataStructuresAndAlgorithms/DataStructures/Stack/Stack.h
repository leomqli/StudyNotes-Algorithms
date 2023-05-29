//
//  Stack.h
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/29.
//

#ifndef Stack_h
#define Stack_h

#include "BaseDefine.h"

/* 顺序栈结构 */
typedef struct {
	ElemType data[MAXSIZE];
	/* 用于栈顶指针 */
	int top;
} SqStack;

void run006(void);

#endif /* Stack_h */
