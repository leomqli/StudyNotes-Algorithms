//
//  002-504. 七进制数.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/10/3.
//

#include "002-504. 七进制数.h"
#include "006-栈的线性实现.h"

/*
 
 https://leetcode.cn/problems/base-7/description/
 
 给定一个整数 num，将其转化为 7 进制，并以字符串形式输出。

 示例 1:
 输入: num = 100
 输出: "202"
 
 示例 2:
 输入: num = -7
 输出: "-10"
  

 提示：
 -10^7 <= num <= 10^7
 
 */

void alg002(void) {
	
	int N = 100;
	SqStack S;
	ElemType e;
	
	// 1.初始化一个空栈S
	InitStack(&S);
	
	// 2.当十进制N非零时,循环执行以下操作
	//	* 把N与7求余得到的七进制数压入栈S;
	//	* N更新为N与7的商;
	while (N) {
		SqStackPush(&S, N%7);
		N = N/7;
	}
	
	// 3.当栈S非空时,循环执行以下操作
	//	* 弹出栈顶元素e;
	//	* 输出e;
	while (!StackEmpty(S)) {
		SqStackPop(&S, &e);
		printf("%d",e);
	}
	
	printf("\n");
}
