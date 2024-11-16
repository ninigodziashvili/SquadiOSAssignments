//
//  Correct.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//
/*ეს არის ISP-ის პრინციპის სწორი მიდგომა
 შემქნილია განსხვავებული პროტოკოლები, რომელიც შეგვიძლია მოვარგოთ თითოეულ პირს თავიანთი როლის შესაბამისად, ეს მიდგომა ამარტივებს თითოეულ კლასს, ხელს უწყობს რომ არ იქნას როლის ფუქნციები არასწორად გამოყენებული. საერთო კოდის ჩანაწერს უფრო მკაფიოს და გასაგებს ხდის */

protocol Readable {
    func readDocument(id: String) -> String
}

protocol Writable {
    func writeDocument(id: String, content: String)
}

protocol Deletable {
    func deleteDocument(id: String)
}

class Admin: Readable, Writable, Deletable {
    func readDocument(id: String) -> String {
        return "Admin reads document \(id)"
    }
    
    func writeDocument(id: String, content: String) {
    }
    
    func deleteDocument(id: String) {
    }
}

class Editor: Readable, Writable {
    func readDocument(id: String) -> String {
        return "Editor reads document \(id)"
    }
    
    func writeDocument(id: String, content: String) {
    }
}

class Viewer: Readable {
    func readDocument(id: String) -> String {
        return "Viewer reads document \(id)"
    }
}
