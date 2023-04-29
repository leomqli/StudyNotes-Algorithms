//
//  118. 杨辉三角.swift
//  Algorithms
//
//  Created by Leo on 2022-11-27.
//
//  https://leetcode.cn/problems/pascals-triangle

/*
 
 给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。
 在「杨辉三角」中，每个数是它左上方和右上方的数的和。

 示例 1:
 输入: numRows = 5
 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
 
 示例 2:
 输入: numRows = 1
 输出: [[1]]

 提示:
 1 <= numRows <= 30
 
 */


extension Algorithm {
    static func test118() {
        let numRows = 5 // [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
//        let numRows = 1 // [[1]]
        print(Solution().generate(numRows))
    }
}

extension Solution {
    
    /// 循环遍历
    /// 时间复杂度：O(numRows^2)
    /// 空间复杂度：O(1)。不考虑返回值的空间占用。
    /// 时间 0 ms  击败 100%
    /// 内存 14 MB 击败 11.59%
    func generate(_ numRows: Int) -> [[Int]] {
        
        var result: [[Int]] = []
        
        for i in 0 ..< numRows {
            
            var arr = [Int]()

            for j in 0 ... i {
                if j == 0 || j == i {
                    arr.append(1)
                } else {
                    let tmpArr = result[i - 1]
                    let num = tmpArr[j - 1] + tmpArr[j]
                    arr.append(num)
                }
            }
            result.append(arr)
        }
        
        return result
    }
}
