//
//  MessageService.swift
//  Smack
//
//  Created by robot on 7/4/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation;
import Alamofire;
import SwiftyJSON;

class MessageService {
    
    static let instance = MessageService();
    
    var channels = [Channel]();
    
    //Check this function!!!
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data
                    else {
                        return;
                }
                
                //Checking the list of channels (not working currently)
                for value in response.result.value as! [Channel] {
                    if let description = value.channelDescription, let title = value.channelTitle {
                        print("Channel Description:\(description)");
                        print("Channel Description:\(title)");
                    } else {
                        print("No channels found.");
                    }
                    
                }
                //Swift 4 decoding JSON (iOS 10+)
                /*
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data);
                } catch let error {
                    print(error.localizedDescription);
                }
                */
                
                do {
                    if let json = try JSON(data: data).array
                    {
                        for item in json {
                            let name = item["name"].stringValue;
                            let channelDescription = item["description"].stringValue;
                            let id = item["_id"].stringValue;
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id);
                            self.channels.append(channel);
                        }
                        //Printing the list of active channels.
                        /*
                        if let activeChannel = self.channels[1].channelTitle {
                            print(activeChannel);
                        } else {
                            print("There are no current active channels on a server.")
                        }
                        */
                        completion(true);
                    }
                } catch {
                    print(error);
                }
                
            } else {
                completion(false);
                debugPrint(response.result.error as Any);
            }
            
        }
        
    }
    
}
