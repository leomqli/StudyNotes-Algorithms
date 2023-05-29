//
//  004-双向循环链表.c
//  DataStructures
//
//  Created by Leo on 2023/5/23.
//

#include "ListNode.h"

// 4.1、双向循环链表初始化
Status createCycleLinkList(DoublyLinkList *L) {

	*L = (DoublyLinkList)malloc(sizeof(DoublyNode));

	if (*L == NULL) return ERROR;

	(*L)->next  = (*L);
	(*L)->prior = (*L);

	//新增数据
	DoublyLinkList p = *L;
	for (int i = 0; i < 10; i++) {

		//1.创建1个临时的结点
		DoublyLinkList temp = (DoublyLinkList)malloc(sizeof(DoublyNode));
		temp->data = i;

		//2.为新增的结点建立双向链表关系
		//① temp 是p的后继
		p->next = temp;
		//② temp 的前驱是p
		temp->prior = p;
		//③ temp的后继是*L
		temp->next = (*L);
		//④ p 的前驱是新建的temp
		p->prior = temp;
		//⑤ p 要记录最后的结点的位置,方便下一次插入
		p = p->next;
	}

	return SUCCESS;
}

// 4.2、双向循环链表插入元素
/*当插入位置超过链表长度则插入到链表末尾*/
Status DoublyCycleLinkListInsert(DoublyLinkList *L, int index, ElemType e) {

	//1. 创建指针p,指向双向链表头
	DoublyLinkList p = (*L);
	int i = 1;

	//2.双向循环链表为空,则返回error
	if(*L == NULL) return ERROR;

	//3.找到插入前一个位置上的结点p
	while (i < index && p->next != *L) {
		p = p->next;
		i++;
	}

	//4.如果i>index 则返回error
	if (i > index)  return ERROR;

	//5.创建新结点temp
	DoublyLinkList temp = (DoublyLinkList)malloc(sizeof(DoublyNode));

	//6.temp 结点为空,则返回error
	if (temp == NULL) return ERROR;

	//7.将生成的新结点temp数据域赋值e.
	temp->data = e;

	//8.将结点temp 的前驱结点为p;
	temp->prior = p;

	//9.temp的后继结点指向p->next;
	temp->next = p->next;

	//10.p的后继结点为新结点temp;
	p->next = temp;

	//如果temp 结点不是最后一个结点
	if (*L != temp->next) {
		//11.temp节点的下一个结点的前驱为temp 结点
		temp->next->prior = temp;
	} else {
		(*L)->prior = temp;
	}

	return SUCCESS;
}

// 4.3、遍历双向循环链表
Status Display(DoublyLinkList L) {

	if (L == NULL) {
		printf("打印的双向循环链表为空!\n\n");
		return ERROR;
	}

	printf("双向循环链表内容: ");
	DoublyLinkList p = L->next;
	while (p != L) {
		printf("%d ", p->data);
		p = p->next;
	}
	printf("\n\n");

	return SUCCESS;
}

// 4.4、双向循环链表删除结点
Status DoublyCycleLinkListDelete(DoublyLinkList *L, int index, ElemType *e) {

	int i = 1;
	DoublyLinkList temp = (*L)->next;

	if (*L == NULL) return  ERROR;

	//①.如果删除到只剩下首元结点了,则直接将*L置空;
	if(temp->next == *L){
		free(*L);
		(*L) = NULL;
		return SUCCESS;
	}

	//1.找到要删除的结点
	while (i < index) {
		temp = temp->next;
		i++;
	}

	//2.给e赋值要删除结点的数据域
	*e = temp->data;

	//3.修改被删除结点的前驱结点的后继指针 图1️⃣
	temp->prior->next = temp->next;

	//4.修改被删除结点的后继结点的前驱指针 图2️⃣
	temp->next->prior = temp->prior;

	//5.删除结点temp
	free(temp);

	return SUCCESS;
}

void run004(void) {
	// insert code here...
	printf("Hello, World!\n");

	DoublyLinkList L;
	Status iStatus;
	ElemType temp,item;

	iStatus = createCycleLinkList(&L);
	printf("双向循环链表初始化是否成功(1->YES)/ (0->NO):  %d\n\n",iStatus);
	Display(L);

	printf("输入要插入的位置和数据用空格隔开：");
	scanf("%d %d",&temp,&item);
	iStatus = DoublyCycleLinkListInsert(&L,temp,item);
	Display(L);

	printf("输入要删除位置：");
	scanf("%d",&temp);
	iStatus = DoublyCycleLinkListDelete(&L, temp, &item);
	printf("删除链表位置为%d,结点数据域为:%d\n",temp,item);
	Display(L);
}
