//
//  008-栈与递归.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/5/29.
//

#include "008-栈与递归.h"

/*
 
 下⾯面3种情况下，我们会使⽤用到递归来解决问题
	1.数学定义是递归的（阶乘/斐波那契数列）
	2.数据结构是递归的（链表）
	3.问题的解法是递归的（汉诺塔问题/八皇后问题/迷宫问题）
 
 递归解法思想
	1.分治法的条件
		a.能够将大问题拆成小问题且大小问题的解法都是一样的；
		b.能通过分治进行解题方式的简化；
		c.必须有递归出口，即边界。
 
 能用迭代、循环，尽量不用递归，会浪费很多空间!
 
 */

/// 斐波那契数列
int Fibonacci(int i) {
	if (i < 2)
		return i == 0 ? 0 : 1;
	else
		return Fibonacci(i - 1) + Fibonacci(i - 2);
}


/// 汉诺塔问题
int m = 0;
void moves(char X, int n, char Y) {
	m++;
	printf("%d: from %c ——> %c \n", n, X, Y);
}

//n为当前盘子编号. ABC为塔盘
void Hanoi(int n, char A, char B, char C) {
	
	//目标: 将塔盘A上的圆盘按规则移动到塔盘C上,B作为辅助塔盘;
	
	//将编号为1的圆盘从A移动到C上
	if (n == 1) {
		moves(A, 1, C);
	} else {
		//将塔盘A上的编号为1至n-1的圆盘移动到塔盘B上,C作为辅助塔;
		Hanoi(n-1, A, C, B);
		//将编号为n的圆盘从A移动到C上;
		moves(A, n, C);
		//将塔盘B上的编号为1至n-1的圆盘移动到塔盘C上,A作为辅助塔;
		Hanoi(n-1, B, A, C);
	}
}

void run008(void) {

	printf("斐波那契数列!\n");
	// 1 1 2 3 5 8 13 21 34 55 89 144
	for (int i = 0; i < 10; i++) {
		 printf("%d  ", Fibonacci(i));
	}
	
	printf("\n");
	printf("Hanoi 塔问题\n");
	
	Hanoi(3, 'A', 'B', 'C');
	printf("盘子数量为3:一共实现搬到次数:%d\n",m);
	Hanoi(4, 'A', 'B', 'C');
	printf("盘子数量为3:一共实现搬到次数:%d\n",m);
}
