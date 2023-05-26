//
//  Sort.swift
//  Algorithms
//
//  Created by Leo on 2022-12-05.
//

extension Sort {
    
    // 冒泡排序
    func sort(_ arr: [Int]) -> [Int] {
        
        var result = arr
        let count = result.count
        
        for i in 0 ..< count {
            
            for j in i + 1 ..< count {
                
                print("i == \(i), j == \(j)")
                
                if result[i] < result[j] {
                    break
                }
                
                if result[i] > result[j] {
                    (result[i], result[j]) = (result[j], result[i])
                }
            }
            print("")
        }
        
        return result
    }
}

