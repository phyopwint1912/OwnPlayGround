//
//  Word.swift
//  OwnPlayground
//
//  Created by Phyo Pwint  on 26/4/16.
//  Copyright © 2016 Phyo Pwint . All rights reserved.
//

import Foundation
class Word {
    var word : String
    var type : String
    var desc : String
    
    init() {
        self.word = ""
        self.type = ""
        self.desc = ""
    }
    
    init(word: String, type: String, desc: String) {
        self.word = word
        self.type = type
        self.desc = desc
    }
    
}

