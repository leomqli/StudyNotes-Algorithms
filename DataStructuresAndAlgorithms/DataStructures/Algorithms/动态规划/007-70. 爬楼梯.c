//
//  007-70. 爬楼梯.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/10/3.
//

/*
 
 https://leetcode.cn/problems/climbing-stairs/description/
 
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

 示例 1：
 输入：n = 2
 输出：2
 解释：有两种方法可以爬到楼顶。
		1. 1 阶 + 1 阶
		2. 2 阶
 
 示例 2：
 输入：n = 3
 输出：3
 解释：有三种方法可以爬到楼顶。
		1. 1 阶 + 1 阶 + 1 阶
		2. 1 阶 + 2 阶
		3. 2 阶 + 1 阶
  
 提示：
 1 <= n <= 45
 
*/

#include "007-70. 爬楼梯.h"

/*
 方法一：递归求解法
 f(n) = f(n-1) + f(n-2);
 f(1)=1;
 f(2)=1;
 */
int ClimbStairs1(int n) {
	
	if (n < 1)  return 0;
	if (n == 1) return 1;
	if (n == 2) return 2;
	
	return ClimbStairs1(n - 1) + ClimbStairs1(n - 2);
}

/*
 方法二：动态规划法
 */
int ClimbStairs2(int n) {
	if (n == 1) return 1;
	
	int temp = n+1;
	int *sum = (int *)malloc(sizeof(int) * (temp));
	
	sum[0] = 0;
	sum[1] = 1;
	sum[2] = 2;
	
	for (int i = 3; i <= n; i++) {
		sum[i] = sum[i-1] + sum[i-2];
	}
	
	return sum[n];
}

void alg007(void) {
	printf("爬楼梯问题\n");
	int reslut = 0;
	
	reslut = ClimbStairs1(5);
	printf("%d\n",reslut);
	
	reslut = ClimbStairs2(5);
	printf("%d\n",reslut);
}
