//
//  009-队列的线性实现.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/30.
//

#include "009-队列的线性实现.h"

/// 循环队列的顺序存储结构
typedef struct {
	ElemType data[MAXSIZE];
	/// 头指针
	int front;
	/// 尾指针，若队列不空，指向队列尾元素的下一个位置
	int rear;
} SqQueue;

/// 9.1、初始化一个空队列Q
Status InitSqQueue(SqQueue *Q) {
	Q->front = 0;
	Q->rear = 0;
	return SUCCESS;
}

/// 9.2、将队列清空
Status ClearSqQueue(SqQueue *Q) {
	Q->front = Q->rear = 0;
	return SUCCESS;
}

/// 9.3、若队列Q为空队列，则返回TRUR，否则返回FALSE。
Status SqQueueEmpty(SqQueue Q) {
	//队空标记
	if (Q.front == Q.rear)
		return TRUE;
	else
		return FALSE;
}

/// 9.4、返回Q的元素个数，也就是队列的当前长度
int SqQueueLength(SqQueue Q){
	return (Q.rear - Q.front + MAXSIZE) % MAXSIZE;
}

/// 9.5、若队列不空，则用e返回Q的队头元素，并返回OK，否则返回ERROR。
Status GetSqQueueHead(SqQueue Q, ElemType *e) {
	//队列已空
	if (Q.front == Q.rear)
		return ERROR;
	else
		*e = Q.data[Q.front];
	
	return SUCCESS;
}

/// 9.6、若队列未满，则插入元素e为新队尾元素
Status InsetSqQueue(SqQueue *Q, ElemType e) {
	
	// 队列已满
	if ((Q->rear + 1) % MAXSIZE == Q->front) return ERROR;
	
	// 将元素e赋值给队尾
	Q->data[Q->rear] = e;
	
	// rear指针向后移动一位，若到最后则转到数组头部;
	Q->rear = (Q->rear + 1) % MAXSIZE;
	
	return SUCCESS;
}

/// 9.7、若队列不空，则删除Q中队头的元素，用e返回值
Status DeleteSqQueue(SqQueue *Q, ElemType *e) {
   
	// 判断队列是否为空
	if (Q->front == Q->rear) return ERROR;
	
	// 将队头元素赋值给e
	*e = Q->data[Q->front];
	
	// front 指针向后移动一位，若到最后则转到数组头部
	Q->front = (Q->front + 1) % MAXSIZE;
	
	return SUCCESS;
}

/// 9.8、从队头到队尾依次对队列的每个元素数组
Status SqQueueTraverse(SqQueue Q) {
	int i = Q.front;
	
	while ((i + Q.front) != Q.rear) {
		printf("%d ", Q.data[i]);
		i = (i + 1) % MAXSIZE;
	}
	printf("\n");
	
	return SUCCESS;
}

void run009(void) {

	printf("001--顺序队列表示与操作实现\n");
	
	Status j;
	int i = 0;
	ElemType d;
	SqQueue Q;
	InitSqQueue(&Q);
	printf("初始化队列后，队列空否？%u(1:空 0:否)\n", SqQueueEmpty(Q));
	
	printf("入队:\n");
	while (i < 10) {
		InsetSqQueue(&Q, i);
		i++;
	}
	SqQueueTraverse(Q);
	printf("队列长度为: %d\n", SqQueueLength(Q));
	printf("现在队列空否？%u(1:空 0:否)\n", SqQueueEmpty(Q));
	printf("出队:\n");
   
	//出队
	DeleteSqQueue(&Q, &d);
	printf("出队的元素:%d\n", d);
	SqQueueTraverse(Q);

	//获取队头
	j = GetSqQueueHead(Q,&d);
	if(j) printf("现在队头元素为: %d\n", d);
	
	ClearSqQueue(&Q);
	printf("清空队列后, 队列空否？%u(1:空 0:否)\n", SqQueueEmpty(Q));
}
