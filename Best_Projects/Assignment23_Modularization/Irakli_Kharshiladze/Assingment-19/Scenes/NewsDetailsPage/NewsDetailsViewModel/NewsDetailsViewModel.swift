//
//  NewsDetailsViewModel.swift
//  Assingment-19
//
//  Created by irakli kharshiladze on 10.11.24.
//
import DateFormatterUtility

final class NewsDetailsViewModel {
    private let dateFormatter: CustomDateFormatterProtocol
    
    init(dateFormatter: CustomDateFormatterProtocol = CustomDateFormatter()) {
        self.dateFormatter = dateFormatter
    }
    
    func formatDate(date: String, inputFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ", outputFormat: String = "EEEE, d MMMM yyyy") -> String {
        return dateFormatter.formattedDate(from: date, inputFormat: inputFormat, outputFormat: outputFormat)
    }
}
