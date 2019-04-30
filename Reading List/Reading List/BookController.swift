//
//  BookController.swift
//  Reading List
//
//  Created by John Pitts on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    func saveToPersisentStore() {
        guard let url = readingListURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            // write to disc next line
            try data.write(to: url)
        } catch /*the error*/ {
            print("error savings book(s?): \(error)")
        }
    }
    
    
    
    
    
    
    
    
    //create a computer copy? is that what he said?
    private var readingListURL: URL? {
        // we could also do let filename: string = "readingList.plist"
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        print("Documents: \(documents.path)") // this is just so i can see the url assigned?
        return documents.appendingPathComponent("readingList.plist")
    }
    
    private(set) var books: [Book] = [] // why do i use "set"? here
    private var readingListURL: URL?
    
}
