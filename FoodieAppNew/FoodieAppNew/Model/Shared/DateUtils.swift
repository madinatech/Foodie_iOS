
import UIKit

class DateUtils: NSObject {
    
  class func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY, hh:mm a"
        let strMonth = dateFormatter.string(from: Date())
        return strMonth
    }
    
   class func getDateFromDatetime(_ dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
       
        let Date24 = dateFormatter.string(from: date!)
        var currentDate = UTCToLocal(date: Date24)
        if(date == nil) {
            currentDate = ""
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date1 = dateFormatter.date (from: currentDate)
        return date1!
    }
    
   class func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dt = dateFormatter.date(from: date)
        //dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    
    
    class func getStringFormat(str:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/M/yy"
        let date: Date = dateFormatterGet.date(from: str)!
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        return dateFormatterPrint.string(from: date)
    }
    class func getTimeString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm a"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getTimeStringFormat(str:String) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let date: Date = formatter.date(from: str)!
        return formatter.string(from: date)
    }
    
    class func getDateTimeStringUTC(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateTimeString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy hh:mm a"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateYearString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateddmmyyyyString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getUTCDateddmmyyyyString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateyyyddmmString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateTimeFromString(str: String) -> Date {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatterPrint.date(from: str)!
    }
    
    class func getFullDateFromString(str: String) -> Date {
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
//        return dateFormatterPrint.date(from: str)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: str)
        return date!
    }
    
    class func getAppDateString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
         dateFormatterPrint.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
         dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.dateFormat = "yyyy-MM-dd hh:mm a"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getTimeFromDate(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
        dateFormatterPrint.dateFormat = "hh:mm a"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getTimeFromDateT(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm a"
        return dateFormatterPrint.string(from: date)
    }
    
    class func get24UTCTimeFromDate(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
        dateFormatterPrint.dateFormat = "HH:mm"
        return dateFormatterPrint.string(from: date)
    }
    
    class func get24TimeFromDate(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getTimeHHMMSSZFromDate(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
        dateFormatterPrint.dateFormat =  "HH:mm:ss.SSSZ"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateLLLL(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "LLLL dd yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateddLLLLyyyy(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd LLLL, yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getAppDateRecentString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM"
        return dateFormatterPrint.string(from: date)
    }
   
    class func getDDString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getYYYYString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        return dateFormatterPrint.string(from: date)
    }
    class func getMMMMString(date:Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getHourString(date:Date) -> Int {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH"
        return Int(dateFormatterPrint.string(from: date))!
    }
    
    class func getMinString(date:Date) -> Int {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "mm"
        return Int(dateFormatterPrint.string(from: date))!
    }
    
   
    
    class func getDateStringDash(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateStringTT(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let dateFormatterPrint = DateFormatter()
        dateFormatterGet.timeZone = NSTimeZone.init(name: "UTC")! as TimeZone
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        return dateFormatterGet.string(from: date)
    }
    
    class func getDateStringFormat(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyyMMdd"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getDateStringTime(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getSameDateFormat(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: date)
    }
    
    class func getFullDateFormat(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: date)
    }
    
    class func convertStringToDateFormat(dateString:String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-M-d H:m:ss"
        return dateFormatterGet.date(from: dateString)!
    }
    
    class func convertStrToDateFormat(dateString:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a" //Your date format
        let date = dateFormatter.date(from: dateString) //according to date format your date string
        return date!
    }
    
    class func convertDateToStringFormat(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatterGet.string(from: date)
    }
    
    class func convertStringDateToStringFormat(str:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
         let date = dateFormatterGet.date(from: str)
        return dateFormatterGet.string(from: date!)
    }
    
    class func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let str_s_date = dateFormatterGet.string(from: startDate)
        let s_date = dateFormatterGet.date(from: str_s_date)
        
        let str_e_date = dateFormatterGet.string(from: endDate)
        let e_date = dateFormatterGet.date(from: str_e_date)
        
        let components = calendar.dateComponents([Calendar.Component.day], from: s_date!, to: e_date!)
        return components.day!
    }
   
    class func getDateDifference(startDate: Date, endDate: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: endDate) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: startDate) else { return 0 }
        return start - end
    }
    
    class func serverSendDateFormat(date:Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatterGet.string(from: date)
    }
    
    class func getDate(date: Date) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter .dateStyle = DateFormatter.Style.short
        
        let dateAsString = dateFormatter.string(from: date)
        return dateFormatter.date(from: dateAsString)!
    }
}
