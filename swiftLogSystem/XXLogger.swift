//
//  XXLogFormat.swift
//  swiftLogSystem
//
//  Created by tomxiang on 6/14/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//  https://blog.cnbluebox.com/blog/2014/06/06/shi-yong-cocoalumberjackhe-xcodecolorsshi-xian-fen-ji-loghe-kong-zhi-tai-yan-se/

import Foundation

// 记录日志+异常上报

func LogDebug(tag:String, text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogDebug(String("\(tag):\(text)"), file: file, function: function, line: line)
}
func LogInfo(tag:String, text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogInfo(String("\(tag):\(text)"), file: file, function: function, line: line)
}
func LogWarn(tag:String, text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogWarn(String("\(tag):\(text)"), file: file, function: function, line: line)
}
func LogError(tag:String, text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogError(String("\(tag):\(text)"), file: file, function: function, line: line)
}
func LogVBOSE(tag:String, text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    DDLogVerbose(String("\(tag):\(text)"), file: file, function: function, line: line)
}


func LogAssert(tag:String, condition: Bool, _ text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    if condition == false {
        DDLogError(String("\(tag):\(text)"), file: file, function: function, line: line)
    }
}

// 日志上传到服务器
func LogUpdate(tag:String, text: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
    assert(false)
}

struct XXLogger {
    
    static var filePath:String?
    static let cachePath = NSHomeDirectory() + "/Library/Caches/Logs/"

    class XXLogFormat:NSObject, DDLogFormatter {
        
        func formatLogMessage(logMessage: DDLogMessage!) -> String! {
            var logLevel:String?
            
            switch logMessage.flag {
            case DDLogFlag.Error:
                logLevel = "[ERROR] > "
                
            case DDLogFlag.Warning:
                logLevel = "[WARN] > "
            
            case DDLogFlag.Info:
                logLevel = "[INFO] >"
            
            case DDLogFlag.Debug:
                logLevel = "[DEBUG] > "
            
            default:
                logLevel = "[VBOSE] > "
            }
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            
            let dateStr = formatter.stringFromDate(logMessage.timestamp)
            let log = "[\(logLevel)] \(dateStr) [\(logMessage.fileName) \(logMessage.function)](\(logMessage.line)) \(logMessage.message)"
            
            return log
        }
    }

    static func initialize() {
        DDLog.addLogger(DDASLLogger.sharedInstance())
        DDLog.addLogger(DDTTYLogger.sharedInstance())
        
        let fileLogger:DDFileLogger!=DDFileLogger()
        fileLogger!.rollingFrequency = 60 * 60 * 24; // 24 hour 一个LogFile的有效期长，有效期内Log都会写入该LogFile
        fileLogger!.logFileManager.maximumNumberOfLogFiles = 5;//最多LogFile的数量

        let logFormat:XXLogFormat! = XXLogFormat()
        fileLogger!.logFormatter = logFormat

        DDLog.addLogger(fileLogger)
        
        filePath = fileLogger!.currentLogFileInfo().filePath
    }
    
    static func getFileLogger()->[String]{
        var arrayCacheTemp:[String]?
        do{
            arrayCacheTemp =  try NSFileManager.defaultManager().contentsOfDirectoryAtPath(cachePath) as [String]
        }catch{}
        
        var arrayCache:[String] = [String]()
        for fileName in arrayCacheTemp! {
            if fileName.containsString("log") {
                arrayCache.append(cachePath.stringByAppendingString(fileName))
            }
        }
        
        print("arrayCache: \(arrayCache)")
        return arrayCache
    }
}