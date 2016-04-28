//
//  ModelManager.swift
//  DataBaseDemo
//
//  Created by Krupa-iMac on 05/08/14.
//  Copyright (c) 2014 TheAppGuruz. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("dict.db"))
        }
        return sharedInstance
    }
    
    func getAllWords(tableName: String) -> [Word] {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(tableName)", withArgumentsInArray: nil)
        var marrWord = [Word]()
        if (resultSet != nil) {
            while resultSet.next() {
                let w : Word = Word()
                w.word = resultSet.stringForColumn("word")
                w.type = resultSet.stringForColumn("type")
                w.desc = resultSet.stringForColumn("desc")
                marrWord.append(w)
            }
        }
        sharedInstance.database!.close()
        return marrWord
    }
}
