//
//  DateFormatType.swift
//  RRCommon
//
//  Created by dtrognn on 20/10/24.
//

import Foundation

public enum DateFormatType: String {
    case minute = "mm"
    case hour = "HH"
    case day = "dd"
    case month = "MM"
    case year = "yyyy"
    case dayMonth = "dd/MM"
    case monthYear = "MM/yyyy"
    case dayMonthYear = "dd/MM/yyyy"
    case monthDayYear = "MM/dd/yyyy"
    case dateFull = "HH:mm dd/MM/yyyy"
    case dateFull2 = "dd/MM/yyyy HH:mm"
    case dateFull3 = "HH:mm:ss dd/MM/yyyy"
    case dateFull4 = "dd/MM/yyy HH:mm:ss"
    case yearMonthDay = "yyyy/MM/dd"
    case yearMonthDay2 = "yyyy-MM-dd"
    case multDateFull = "HH:mm\ndd/MM/yyyy"

    case hourMinute = "HH:mm"
    case hourMinuteSeconds = "HH:mm:ss"

    case server = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    case server1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case server2 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case server3 = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    case local = "yyyy-MM-dd'T'HH:mm:ss.000"
}
