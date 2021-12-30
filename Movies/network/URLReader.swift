//
//  UIUtils.swift
//  Nutrition Analysis
//
//  Created by azah on 6/25/21.
//

import UIKit

class URLReader {
    public class func readPropertyList(urlType: String) -> String {
        
        var format = PropertyListSerialization.PropertyListFormat.xml
        var plistData: [String: AnyObject] = [:]
        
        let plistPath: String? = Bundle.main.path(forResource: "urlsList", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)! //the data in XML format
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                                   options: .mutableContainersAndLeaves,
                                                                   format: &format) as! [String: AnyObject]
            let completePath = "\(plistData["baseUrl"]!)/\(plistData[urlType] as! String)"
            print(completePath)
            return completePath
          
            
        } catch { // error condition
            print("Error reading plist")
            return ""
        }
    }
    
}
