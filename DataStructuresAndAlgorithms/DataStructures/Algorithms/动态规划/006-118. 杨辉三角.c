//
//  006-118. 杨辉三角.c
//  DataStructuresAndAlgorithms
//
//  Created by Leo on 2023/10/3.
//

/*
 
 https://leetcode.cn/problems/pascals-triangle/description/
 
 给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。

 在「杨辉三角」中，每个数是它左上方和右上方的数的和。

 示例 1:
 输入: numRows = 5
 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
 
 示例 2:
 输入: numRows = 1
 输出: [[1]]
 
 */

#include "006-118. 杨辉三角.h"

/*
 思路:
 1. 第一层循环控制行数i : 默认[i][0] = 1,[i][i] = 1
 2. 第二层循环控制列数j : triangle[i][j] = triangle[i-1][j-1] + triangle[i-1][j]
 */
int** generate(int numRows, int *returnSize){
	
	*returnSize = numRows;
	
	int **res = (int **)malloc(sizeof(int *) *numRows);
	
	for (int i = 0; i < numRows; i++) {
		res[i] = (int *)malloc(sizeof(int) *(i + 1));
		res[i][0] = 1;
		res[i][i] = 1;
		
		for (int j = 1; j < i; j++) {
			res[i][j] = res[i-1][j] + res[i-1][j-1];
		}
	}
	
	return res;
}

void alg006(void) {
	
	printf("杨辉三角问题\n");
	int numRows = 5;
	int returnSize;
	int **returnResult;
	
	returnResult = generate(numRows, &returnSize);
	
	for (int i = 0; i < returnSize; i++) {
		printf("[");
		for (int j = 0; j <= i; j++) {
			printf(" %d ",returnResult[i][j]);
		}
		printf("]\n");
	}
}
