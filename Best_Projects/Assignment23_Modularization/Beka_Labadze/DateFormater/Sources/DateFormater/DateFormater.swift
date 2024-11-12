// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol DateFormatterProtocol {
    func formatDate(_ dateString: String) -> String
}

public class DateFormater: DateFormatterProtocol {
    public init(){}
    public func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
