//
//  ListNode.h
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/26.
//

#ifndef ListNode_h
#define ListNode_h

#include <stdio.h>
#include "string.h"
#include "ctype.h"
#include "stdlib.h"
#include "math.h"
#include "time.h"

#define SUCCESS 1
#define ERROR 0

#define TRUE 1
#define FALSE 0

#define MAXSIZE 20

/// Status是函数的类型,其值是函数结果状态代码，如OK等
typedef int Status;

/// ElemType类型根据实际情况而定，这里假设为int
typedef int ElemType;

/// 定义结点
typedef struct Node {
	ElemType data;
	struct Node *next;
} Node;

// 定义双向链表结点
typedef struct DoublyNode {
	ElemType data;
	struct DoublyNode *prior;
	struct DoublyNode *next;
} DoublyNode;

typedef struct DoublyNode *DoublyLinkList;

/// 节点
typedef struct Node *LinkList;

void run001(void);
void run002(void);
void run003(void);
void run004(void);
void run005(void);

#endif /* ListNode_h */
