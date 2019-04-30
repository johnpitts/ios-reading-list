//
//  BookController.swift
//  Reading List
//
//  Created by John Pitts on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        //load fr persis store func call
    }
    
    //CRUD methods
    
    func createBook(titled title: String, for reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead) // boolean ok here?
        books.append(book)
        
        saveToPersisentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return}
        books.remove(at: index)
        
        saveToPersisentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = true
        
        saveToPersisentStore()
        
    }
    
    func update(book: Book, with newTitle: String, with newReasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = newTitle
        books[index].reasonToRead = newReasonToRead
        
        saveToPersisentStore()
    }
    
    
    
     =
    
    func saveToPersisentStore() {
        guard let url = readingListURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)  //booksData is memories name for array
            // write books array to disc at address url aka readingList.plist
            try booksData.write(to: url)
        } catch /*the error, in case writing to disc fails for some reason*/ {
            print("error savings book(s?): \(error)")
        }
        //return booksData // i don't know if this satisfies "url that appends readingList.plist
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return}
        
        //load a decode
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: data) //system knows how to decode an array
            books = decodeBooks  // is this REALLY necessary?
        } catch {
            print("error loading data from disk \(error)")
        }
    }
    
    
    
    private var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    private var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
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

    
}
