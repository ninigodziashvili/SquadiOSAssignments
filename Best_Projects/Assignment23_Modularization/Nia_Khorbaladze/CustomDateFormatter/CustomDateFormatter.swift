//
//  CustomDateFormatter.swift
//  CustomDateFormatter
//
//  Created by Nkhorbaladze on 11.11.24.
//

import Foundation

public protocol CustomFormatting {
    func formatDate(_ dateFromResponse: String?) -> String?
}

public class DateFormatterHelper: CustomFormatting {
    public init() {}
    
    public func formatDate(_ dateFromResponse: String?) -> String? {
        guard let dateFromResponse = dateFromResponse else { return "No Date" }
        
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateFromResponse) {
            let displayFormatter = Foundation.DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return "No Date"
    }
}
