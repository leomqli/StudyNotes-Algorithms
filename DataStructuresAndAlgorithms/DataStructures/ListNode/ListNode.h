//
//  ListNode.h
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/26.
//

#ifndef ListNode_h
#define ListNode_h

#include "BaseDefine.h"

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
