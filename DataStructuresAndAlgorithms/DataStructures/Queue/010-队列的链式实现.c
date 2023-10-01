//
//  010-队列的链式实现.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/30.
//

#include "010-队列的链式实现.h"

/// 结点结构
typedef struct QNode {
	ElemType data;
	struct QNode *next;
} QNode, *QueuePtr;

/// 队列的链表结构
typedef struct {
	// 队头指针
	QueuePtr front;
	// 队尾指针
	QueuePtr rear;
} LinkQueue;

/// 10.1 初始化队列
Status InitLinkQueue(LinkQueue *Q) {
	// 1. 头/尾指针都指向新生成的结点
	Q->front = Q->rear = (QueuePtr)malloc(sizeof(QNode));

	// 2.判断是否创建新结点成功与否
	if (!Q->front) {
		return ERROR;
	}

	// 3.头结点的指针域置空
	Q->front->next = NULL;
	
	return SUCCESS;
}

/// 10.2 销毁队列Q
Status DestoryLinkQueue(LinkQueue *Q) {
	
	//遍历整个队列,销毁队列的每个结点
	while (Q->front) {
		Q->rear = Q->front->next;
		free(Q->front);
		Q->front = Q->rear;
	}
	return SUCCESS;
}

/// 10.3 将队列Q置空
Status ClearLinkQueue(LinkQueue *Q) {
	
	QueuePtr p,q;
	Q->rear = Q->front;
	p = Q->front->next;
	Q->front->next = NULL;
	
	while (p) {
		q = p;
		p = p->next;
		free(q);
	}
	
	return SUCCESS;
}

/// 10.4 判断队列Q是否为空
Status LinkQueueEmpty(LinkQueue Q) {
	if (Q.front == Q.rear)
		return TRUE;
	else
		return FALSE;
}

/// 10.5 获取队列长度
int LinkQueueLength(LinkQueue Q) {
	int i = 0;
	QueuePtr p;
	p = Q.front;
	while (Q.rear != p) {
		i++;
		p = p->next;
	}
	return i;
}

/// 10.6 插入元素e为队列Q的新元素
Status InsetLinkQueue(LinkQueue *Q, ElemType e) {
	
	//为入队元素分配结点空间,用指针s指向;
	QueuePtr s = (QueuePtr)malloc(sizeof(QNode));
	
	//判断是否分配成功
	if (!s) return ERROR;
	
	//将新结点s指定数据域.
	s->data = e;
	s->next = NULL;
	
	//将新结点插入到队尾
	Q->rear->next = s;
	
	//修改队尾指针
	Q->rear = s;
	
	return SUCCESS;
}

/// 10.7 出队列
Status DeleteLinkQueue(LinkQueue *Q, ElemType *e) {
	
	QueuePtr p;
	
	//判断队列是否为空;
	if (Q->front == Q->rear) return ERROR;
	
	//将要删除的队头结点暂时存储在p
	p = Q->front->next;
	
	//将要删除的队头结点的值赋值给e
	*e = p->data;
	
	//将原队列头结点的后继p->next 赋值给头结点后继
	Q->front->next = p ->next;
	
	//若队头就是队尾,则删除后将rear指向头结点.
	if(Q->rear == p) Q->rear = Q->front;
	
	free(p);
	
	return SUCCESS;
}

/// 10.8 获取队头元素
Status GetLinkQueueHead(LinkQueue Q, ElemType *e) {
   
	//队列非空
	if (Q.front != Q.rear) {
		//返回队头元素的值,队头指针不变
		*e = Q.front->next->data;
		return TRUE;
	}
	
	return  FALSE;
}

/// 10.9 遍历队列
Status LinkQueueTraverse(LinkQueue Q) {
	
	QueuePtr p;
	p = Q.front->next;
	while (p) {
		printf("%d ", p->data);
		p = p->next;
	}
	printf("\n");
	return SUCCESS;
}

void run010(void) {
	// insert code here...
	printf("链队列的表示与操作!\n");
	
	Status iStatus;
	ElemType d;
	LinkQueue q;
	
	//1.初始化队列q
	iStatus = InitLinkQueue(&q);
	
	//2. 判断是否创建成
	if (iStatus) {
		printf("成功地构造了一个空队列\n");
	}
	
	//3.判断队列是否为空
	printf("是否为空队列?%d (1:是 0:否)\n",LinkQueueEmpty(q));
	
	//4.获取队列的长度
	printf("队列的长度为%d\n",LinkQueueLength(q));
	
	//5.插入元素到队列中
	InsetLinkQueue(&q, -3);
	InsetLinkQueue(&q, 6);
	InsetLinkQueue(&q, 12);
	
	printf("队列的长度为%d\n",LinkQueueLength(q));
	printf("是否为空队列?%d (1:是 0:否)\n",LinkQueueEmpty(q));
	
	//6.遍历队列
	printf("队列中的元素如下:\n");
	LinkQueueTraverse(q);

	//7.获取队列头元素
	iStatus = GetLinkQueueHead(q, &d);
	if (iStatus == SUCCESS) {
		printf("队头元素是:%d\n",d);
	}
	
	//8.删除队头元素
	iStatus =DeleteLinkQueue(&q, &d);
	if (iStatus == SUCCESS) {
		printf("删除了的队头元素为:%d\n",d);
	}
	
	//9.获取队头元素
	iStatus = GetLinkQueueHead(q, &d);
	if (iStatus == SUCCESS) {
		printf("新的队头元素为:%d\n",d);
	}
	
	//10.清空队列
	ClearLinkQueue(&q);
	
	//11.销毁队列
	DestoryLinkQueue(&q);
}
