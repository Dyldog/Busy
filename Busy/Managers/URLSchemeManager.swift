//
//  URLSchemeManager.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import Foundation

class URLSchemeManager {
    @UserDefaultable(key: .urlScheme) var urlScheme: String = "x-fantastical3://parse?start=$DATE&end=$DATE+1&" + "x-success=busy://&x-source=Busy&x-error=busy://".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    let dateRegex = try! NSRegularExpression(pattern: "\\$DATE(\\+\\d+)?")
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    func url(for period: DayPeriod, of date: Date) -> URL? {
        var schemeText = urlScheme
        
        while let match = dateRegex.firstMatch(in: schemeText, range: .init(location: 0, length: schemeText.count))?.range {
            
            var dateValue = Calendar.autoupdatingCurrent
                .date(bySettingHour: period.startHour, minute: 0, second: 0, of: date)!
            
            
            if let dateOffset = schemeText[Range(match, in: schemeText)!].components(separatedBy: "+").dropFirst().first?.doubleValue {
                dateValue = dateValue.addingTimeInterval(.oneHour * dateOffset)
            }
            
            schemeText.replaceSubrange(
                Range(match, in: schemeText)!,
                with: dateFormatter.string(from: dateValue)
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            )
        }
        
        return URL(string: schemeText)
    }
}

