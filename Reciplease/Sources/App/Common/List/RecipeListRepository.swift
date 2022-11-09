//
//  RecipeListRepository.swift
//  Reciplease
//
//  Created by Valc0d3 on 09/11/2022.
//

import Foundation
import CoreData

class RecipeListRepository: RecipeListRepositoryType {
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func getRecipes() -> [Recipe] {
        let recipe = Recipe(name: "yolo", image: "https://edamam-product-images.s3.amazonaws.com/web-img/e4f/e4f7146cb6c0806e4287a9c8a69ed64b.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGMaCXVzLWVhc3QtMSJHMEUCIQDw6TLw2aPL0UazNF6VcAohmP7f3OKAY4AOfeUfAFridAIgA%2F7gCQ4Gz3HKX7oUqvuXW8%2FKo0hKVLsyPJsDw%2Fl%2BFHcqzAQIWxAAGgwxODcwMTcxNTA5ODYiDPcsivJw1S%2B60MkkgSqpBFnwIyEW7DiFp%2BL8fQoR3%2FcnuCfuPEsZ8gPzTj18oG5jhn6Lh%2FWCUZnb1y3opbv5n4KSvtQLFQItKB43Za3jBCMBOFTYppoUZmCs532WdQ90%2F%2BMrqLdCXFIwGnBSAsGuc%2BbQhzr75h2AdfyIOp2AJj%2BT7AxHJZyqpwhj5xjMyhDYjjs4akPYLLu0zv7pAx7nfeVDtBnrj2ejwyy2coocGU8AB8ZkeaTnqcw5guQC%2BsFgc2BO%2FYk0WHRMR7lf5z3xigtNyizuBdfCFvoyXByFTuK%2F6l%2BrTqgnUaQLTuDo1RK3ILZNa0QyF2Ah4dkNuy%2FaLTesvAU8vWEMVOWcplYzOrGPRPkwmChq3ttcZXKIMzpepurHaO2pQvt2HBgfScTpHftul6IOynDVRgd1LqvzLArs8Hn2GhtIUsvPq8f9yFV9LtyeM8eIqBITzAmXosU1ZlViQarAXgfZSOlB51sTGHtKiwgkYyzQgwtRfc1ab58U0kf8fpK5RgnPtjAGmxPEXDp1iQ%2FROdpELqz8q7RfJQ0IfRYKqkfjpipeqRt%2BeUuRRU9pxzPbGbD6PXbiWWa28fKTBwxNYgC2l%2B1vXb7BN97ciWH3jkCx39h6xloJo8aI6NIjwEBRvYlzURA8tezwFUAHP6Ztd5z2oZKKZ1UWH%2BB66LzS%2BktPViuTxevA6mSOqRnxn5PyoanBtyBc0jifOsaaX1CcAcl212gzGDlarTh8PFiBHQHoQo4wr%2FmtmwY6qQFndQSZWkMUkdzj09Kd%2BCCYADMip5aMmTWBIPRSyOEcJYvwsa%2FOelJp1sqjfX%2FE0td8ezsFe9jIX2Vg8y6cucoqYRMyaSHKHk6ocYiFS56mMjtoNbc5wl%2FlMop6ZA8rJVl43DqyYsdZo8OCwHY9oN9Fh1I2HXhKdBfnteDZQIZfwlR4Tm7F4DzqeksQIB0ogs7Ld5ZTD9TWmLWaP4TfKW5TEjlNR55bUq2f&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221109T111304Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=ASIASXCYXIIFHBMPVKOT%2F20221109%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=a5a3a8b199bdc256604f203d162a8077f5e22656f5594341646a5a9d847c33ca", url: "www.google.com", source: "bidule", caution: ["yolo"], ingredientLines: ["Une banana", "Une prune", "Du saint moret"], totalTime: 2.0)
        return [recipe]
    }
}

protocol RecipeListRepositoryType {
    func getRecipes() -> [Recipe]
}
