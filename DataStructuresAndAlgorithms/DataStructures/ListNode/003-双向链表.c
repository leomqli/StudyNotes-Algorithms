//
//  003-双向链表.c
//  DataStructures
//
//  Created by Leo on 2023/5/23.
//

#include "ListNode.h"

// 3.1、创建双向链接
Status createLinkList(DoublyLinkList *L) {
	
	//*L 指向头结点
	*L = (DoublyLinkList)malloc(sizeof(DoublyNode));
	if (*L == NULL) return ERROR;
	
	(*L)->prior = NULL;
	(*L)->next = NULL;
	(*L)->data = -1;
	
	//新增数据
	DoublyLinkList p = *L;
	for (int i = 0; i < 10; i++) {
		
		//1.创建1个临时的结点
		DoublyLinkList temp = (DoublyLinkList)malloc(sizeof(DoublyNode));
		if (temp == NULL) return ERROR;
		
		temp->prior = NULL;
		temp->next = NULL;
		temp->data = i;
		
		//2.为新增的结点建立双向链表关系
		//① temp 是p的后继
		p->next = temp;
		//② temp 的前驱是p
		temp->prior = p;
		//③ p 要记录最后的结点的位置,方便下一次插入
		p = p->next;
		
	}
	
	return SUCCESS;
}

// 3.2、打印循环链表的元素
void display(DoublyLinkList L) {
	
	DoublyLinkList temp = L->next;
	
	if (temp == NULL) {
		printf("打印的双向链表为空!\n");
		return;
	}
	
	while (temp) {
		printf("%d ", temp->data);
		temp = temp->next;
	}
	printf("\n");
}

// 3.3、双向链表插入元素
Status DoublyListInsert(DoublyLinkList *L, int i, ElemType data) {
	
	//1. 插入的位置不合法 为0或者为负数
	if (i < 1) return ERROR;
	
	//2. 新建结点
	DoublyLinkList temp = (DoublyLinkList)malloc(sizeof(DoublyNode));
	temp->data = data;
	temp->prior = NULL;
	temp->next = NULL;
	
	//3.将p指向头结点!
	DoublyLinkList p = *L;
	
	//4. 找到插入位置i直接的结点
	for (int j = 1; j < i && p; j++) {
		p = p->next;
	}
	
	//5. 如果插入的位置超过链表本身的长度
	if (p == NULL) return ERROR;
		
	//6. 判断插入位置是否为链表尾部;
	if (p->next == NULL) {
		p->next = temp;
		temp->prior = p;
	} else {
		//1️⃣ 将p->next 结点的前驱prior = temp
		p->next->prior = temp;
		//2️⃣ 将temp->next 指向原来的p->next
		temp->next = p->next;
		//3️⃣ p->next 更新成新创建的temp
		p->next = temp;
		//4️⃣ 新创建的temp前驱 = p
		temp->prior = p;
	}
	
	return SUCCESS;
}

// 3.4、删除双向链表指定位置上的结点
Status DoublyListDelete(DoublyLinkList *L, int i, ElemType *e) {
	
	int k = 1;
	DoublyLinkList p = (*L);
	
	//1.判断双向链表是否为空,如果为空则返回ERROR;
	if (*L == NULL) return ERROR;
  
	//2. 将指针p移动到删除元素位置前一个
	while (k < i && p != NULL) {
		p = p->next;
		k++;
	}
	
	//3.如果k>i 或者 p == NULL 则返回ERROR
	if (k > i || p == NULL) return ERROR;
	
	//4.创建临时指针delTemp 指向要删除的结点,并将要删除的结点的data 赋值给*e,带回到main函数
	DoublyLinkList delTemp = p->next;
	*e = delTemp->data;
	
	//5. p->next 等于要删除的结点的下一个结点
	p->next = delTemp->next;
	
	//6. 如果删除结点的下一个结点不为空,则将将要删除的下一个结点的前驱指针赋值p;
	if (delTemp->next != NULL) {
		delTemp->next->prior = p;
	}
	
	//7. 释放已删除的delTemp结点
	free(delTemp);
	
	return SUCCESS;
}

// 3.5、删除双向链表指定的元素
Status LinkListDeletVAL(DoublyLinkList *L, int data) {
	
	DoublyLinkList p = (*L)->next;
	
	//1.遍历双向循环链表
	while (p) {
		//2.判断当前结点的数据域和data是否相等,若相等则删除该结点
		if (p->data == data) {
			//修改被删除结点的前驱结点的后继指针,参考图上步骤1️⃣
			p->prior->next = p->next;
			
			//修改被删除结点的后继结点的前驱指针,参考图上步骤2️⃣
			if (p->next != NULL) {
				p->next->prior = p->prior;
			}
			
			//释放被删除结点p
			free(p);
			
			//退出循环
			break;
		}
		
		//没有找到该结点,则继续移动指针p
		p = p->next;
	}
	
	return SUCCESS;
}

// 3.6、在双向链表中查找元素
int selectElem(DoublyLinkList L, ElemType elem) {
	
	DoublyLinkList p = L->next;
	int i = 1;
	
	while (p) {
		if (p->data == elem) {
			return i;
		}
		
		i++;
		p = p->next;
	}
	
	return -1;
}

// 3.7、在双向链表中更新结点
Status replaceLinkList(DoublyLinkList *L, int index, ElemType newElem) {
	DoublyLinkList p = (*L)->next;
	
	for (int i = 1; i < index; i++) {
		p = p->next;
	}
	
	p->data = newElem;
	return SUCCESS;
}

void run003(void) {
	// insert code here...
	printf("Hello, World!\n");
	
	Status iStatus = 0;
	DoublyLinkList L;
	int temp,item,e;
	
	iStatus =  createLinkList(&L);
	printf("iStatus = %d\n",iStatus);
	printf("链表创建成功,打印链表:\n");
	display(L);
	
	printf("请输入插入的位置\n");
	scanf("%d %d",&temp,&item);
	iStatus = DoublyListInsert(&L, temp, item);
	printf("插入数据,打印链表:\n");
	display(L);
	
	printf("请输入插入的位置\n");
	scanf("%d %d",&temp,&item);
	iStatus = DoublyListInsert(&L, temp, item);
	printf("插入数据,打印链表:\n");
	display(L);
	
	printf("请输入插入的位置\n");
	scanf("%d %d",&temp,&item);
	iStatus = DoublyListInsert(&L, temp, item);
	printf("插入数据,打印链表:\n");
	display(L);
	
	printf("请输入删除的位置\n");
	scanf("%d",&temp);
	iStatus = DoublyListDelete(&L, temp, &e);
	printf("删除元素: 删除位置为%d,data = %d\n",temp,e);
	printf("删除操作之后的,双向链表:\n");
	display(L);
	
	printf("请输入你要删除的内容\n");
	scanf("%d",&temp);
	iStatus = LinkListDeletVAL(&L, temp);
	printf("删除指定data域等于%d的结点,双向链表:\n",temp);
	display(L);

	printf("请输入你要查找的内容\n");
	 scanf("%d",&temp);
	ElemType index = selectElem(L, temp);
	printf("在双向链表中查找到数据域为%d的结点,位置是:%d\n",temp,index);

	printf("请输入你要更新的结点以及内容\n");
	scanf("%d %d",&temp,&item);
	iStatus = replaceLinkList(&L, temp, item);
	printf("更新结点数据后的双向链表:\n");
	display(L);
}

