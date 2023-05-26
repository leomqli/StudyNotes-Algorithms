//
//  002-单向循环链表.c
//  DataStructures
//
//  Created by Leo on 2023/5/11.
//

#include "ListNode.h"

/*
 1、循环链表创建!
 
 两种情况:
 ①第一次开始创建;
 ②已经创建,往里面新增数据
 
 判断是否第一次创建链表
	YES -> 创建一个新结点,并使得新结点的next 指向自身; (*L)->next = (*L);
	NO  -> 找链表尾结点,将尾结点的next = 新结点. 新结点的next = (*L);
 */
Status CreateList(LinkList *L) {

	int item;
	LinkList temp = NULL;
	LinkList target = NULL;
	printf("输入节点的值，输入0结束\n");
	
	while(1) {
		scanf("%d", &item);
		if (item == 0) break;
		
		  //如果输入的链表是空。则创建一个新的节点，使其next指针指向自己  (*head)->next=*head;
		if (*L == NULL) {
			*L = (LinkList)malloc(sizeof(Node));
			if (!L) return ERROR;
			
			(*L)->data = item;
			(*L)->next = *L;
		} else {
		   //输入的链表不是空的，寻找链表的尾节点，使尾节点的next=新节点。新节点的next指向头节点
			
			for (target = *L; target->next != *L; target = target->next);
			
			temp = (LinkList)malloc(sizeof(Node));
			if (!temp) return ERROR;
			
			temp->data = item;
			// 新节点指向头节点
			temp->next = *L;
			// 尾节点指向新节点
			target->next = temp;
		}
	}
	
	return SUCCESS;
}

Status CreateList2(LinkList *L) {
	
	int item;
	LinkList temp = NULL;
	LinkList r = NULL;
	printf("请输入新的结点, 当输入0时结束!\n");
	
	while (1) {
		scanf("%d", &item);
		if (item == 0) break;
		
		//第一次创建
		if (*L == NULL) {
			
			*L = (LinkList)malloc(sizeof(Node));
			if (!*L) return ERROR;
			
			(*L)->data = item;
			(*L)->next = *L;
			r = *L;
		} else {
			
			temp = (LinkList)malloc(sizeof(Node));
			if (!temp) return  ERROR;
			
			temp->data = item;
			temp->next = *L;
			r->next = temp;
			r = temp;
		}
	}
	
	return SUCCESS;
}

// 2、循环链表插入数据
Status ListInsert(LinkList *L, int place, int num) {
	
	LinkList temp, target;
	int i;
	if (place == 1) {
		
		//如果插入的位置为1,则属于插入首元结点,所以需要特殊处理
		//1. 创建新结点temp,并判断是否创建成功,成功则赋值,否则返回ERROR;
		//2. 找到链表最后的结点_尾结点,
		//3. 让新结点的next 指向头结点.
		//4. 尾结点的next 指向新的头结点;
		//5. 让头指针指向temp(临时的新结点)
		
		temp = (LinkList)malloc(sizeof(Node));
		if (temp == NULL) return ERROR;
		
		temp->data = num;
		
		for (target = *L; target->next != *L; target = target->next);
		
		temp->next = *L;
		target->next = temp;
		*L = temp;
		
	} else {
		
		//如果插入的位置在其他位置;
		//1. 创建新结点temp,并判断是否创建成功,成功则赋值,否则返回ERROR;
		//2. 先找到插入的位置,如果超过链表长度,则自动插入队尾;
		//3. 通过target找到要插入位置的前一个结点, 让target->next = temp;
		//4. 插入结点的前驱指向新结点,新结点的next 指向target原来的next位置 ;
		
		temp = (LinkList)malloc(sizeof(Node));
		if (temp == NULL) return ERROR;
		
		temp->data = num;
		
		for (
			 i = 1, target = *L;
			 target->next != *L && i != place - 1;
			 target = target->next, i++
			 );
		
		temp->next = target->next;
		target->next = temp;
	}
	
	return SUCCESS;
}

// 3、循环链表删除元素
Status LinkListDelete(LinkList *L, int place) {
	
	LinkList temp,target;
	int i;
	//temp 指向链表首元结点
	temp = *L;
	if(temp == NULL) return ERROR;
	
	
	if (place == 1) {
		
		//①.如果删除到只剩下首元结点了,则直接将*L置空;
		if((*L)->next == (*L)){
			(*L) = NULL;
			return SUCCESS;
		}
		
		//②.链表还有很多数据,但是删除的是首结点;
		//1. 找到尾结点, 使得尾结点next 指向头结点的下一个结点 target->next = (*L)->next;
		//2. 新结点做为头结点,则释放原来的头结点
		
		for (target = *L; target->next != *L; target = target->next);
		temp = *L;
		
		*L = (*L)->next;
		target->next = *L;
		free(temp);
	} else {

		//如果删除其他结点--其他结点
		//1. 找到删除结点前一个结点target
		//2. 使得target->next 指向下一个结点
		//3. 释放需要删除的结点temp
		for (
			 i = 1, target = *L;
			 target->next != *L && i != place -1;
			 target = target->next, i++
			 );

		temp = target->next;
		target->next = temp->next;
		free(temp);
	}
	
	return SUCCESS;
}

// 4、循环链表查询值
int findValue(LinkList L, int value) {
	
	int i = 1;
	LinkList p;
	p = L;
	
	//寻找链表中的结点 data == value
	while (p->data != value && p->next != L) {
		i++;
		p = p->next;
	}
	
	//当尾结点指向头结点就会直接跳出循环,所以要额外增加一次判断尾结点的data == value;
	if (p->next == L && p->data != value) {
		return  -1;
	}
	
	return i;
}

// 5、遍历循环链表，循环链表的遍历最好用do while语句，因为头节点就有值
void show(LinkList p) {
	//如果链表是空
	if (p == NULL) {
		printf("打印的链表为空!\n");
		return;
	} else {
		LinkList temp;
		temp = p;
		do{
			printf("%5d", temp->data);
			temp = temp->next;
		} while (temp != p);
		printf("\n");
	}
}

void run002(void) {
	
	LinkList head;
	int place, num;
	int iStatus;
	
	//iStatus = CreateList(&head);
	iStatus = CreateList2(&head);
	printf("原始的链表：\n");
	show(head);
	
//    printf("输入要插入的位置和数据用空格隔开：");
//    scanf("%d %d",&place,&num);
//    iStatus = ListInsert(&head,place,num);
//    show(head);

	printf("输入要删除的位置：");
	scanf("%d", &place);
	
	LinkListDelete(&head, place);
	show(head);
	
	printf("输入你想查找的值:");
	scanf("%d", &num);
	
	place = findValue(head, num);
	
	if (place != -1) {
		printf("找到的值的位置是place = %d\n", place);
	} else {
		printf("没找到值\n");
	}
}
