//
//  ContentBlockerRequestHandler.swift
//  EasyBlocker
//
//  Created by Андрей Ильичёв on 08.08.2022.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        //let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
        let documentFolder = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.gidrokolbaska.blockergroup")
        guard let jsonURL = documentFolder?.appendingPathComponent("finalList.json") else {
                    return
                }

                print(jsonURL)

                let attachment = NSItemProvider(contentsOf: jsonURL)
        let item = NSExtensionItem()
        item.attachments = [attachment!]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
   
    
}
