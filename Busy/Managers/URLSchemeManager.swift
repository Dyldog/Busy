//
//  URLSchemeManager.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import Foundation
import DylKit

class URLSchemeManager {
    enum Defaults: String, CaseIterable, DefaultsKey {
        case urlScheme = "URL_SCHEME"
    }

    @UserDefaultable(key: Defaults.urlScheme) var urlScheme: String = "x-fantastical3://parse?start=$DATE&end=$DATE+1&" + "x-success=busy://&x-source=Busy&x-error=busy://".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    let dateRegex = try! NSRegularExpression(pattern: "\\$DATE(\\+\\d+)?")
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    func url(for date: Date, startingAt startTime: (hour: Int, minute: Int)) -> URL? {
        var schemeText = urlScheme
        
        while let match = dateRegex.firstMatch(in: schemeText, range: .init(location: 0, length: schemeText.count))?.range {
            
            var dateValue = Calendar.autoupdatingCurrent
                .date(bySettingHour: startTime.hour, minute: startTime.minute, second: 0, of: date)!
            
            
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

