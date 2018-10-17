//
//  GetSNumber.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 16..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError:Error{
    case badInnerHTML
}

struct GetSNumber{
    
    init(_ innerHtml: Any?) throws {
        guard let htmlString = innerHtml as? String else{
            throw HTMLError.badInnerHTML
        }
        
        let doc = try SwiftSoup.parse(htmlString)
        let id =  try doc.select("td[width=40%]")
        print("tagg", id.size())
        //var snumber:String = try id.get(0).text()
//        let startIdx = snumber.index(of: ":")
//        snumber[NSRange(location: startIdx, length: 12)]
        
        //print("tagg", snumber)
        
    }
    
}
