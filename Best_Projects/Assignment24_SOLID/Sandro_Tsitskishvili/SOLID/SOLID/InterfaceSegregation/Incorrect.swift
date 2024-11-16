//
//  Incorrect.swift
//  SOLID
//
//  Created by Sandro Tsitskishvili on 13.11.24.
//

/* ეს არის ISP-ის პრიციპის დაუცველობის მაგალითი
 ამ სცენარს მიხედვით არის 3 პირი რომელთაც განსხვავებული უფლებები აქვთ
 
ადმინი - კითხულობს, წერს, შლის
ედიტორი - კითხულობს და წერს თუმცა ვერ შლის
მკითხველი - მხოლოდ კითხულობს
 
შექმნილია DocumentService პროტოკოლი რომელიც საშუალებას აძლევს სხვადასხვა პირს მიანიჭოს თავიანთი შესაძლებლობები, შესაბამისად თითოეულმა კლასმა ეს პროტოკოლი უნდა დააიმპლემენტოს იმის მიუხედავად სჭირდებათ თუ არათ მათ ეს.  */

protocol DocumentService {
    func readDocument(id: String) -> String
    func writeDocument(id: String, content: String)
    func deleteDocument(id: String)
}

class Admin: DocumentService {
    func readDocument(id: String) -> String {
        return "Admin reads document \(id)"
    }
    
    func writeDocument(id: String, content: String) {
    }
    
    func deleteDocument(id: String) {
    }
}

class Editor: DocumentService {
    func readDocument(id: String) -> String {
        return "Editor reads document"
    }
    
    func writeDocument(id: String, content: String) {
    }

    func deleteDocument(id: String) {
    }
}

class Viewer: DocumentService {
    func readDocument(id: String) -> String {
        return "Viewer reads document"
    }

    func writeDocument(id: String, content: String) {
    }

    func deleteDocument(id: String) {
    }
}
