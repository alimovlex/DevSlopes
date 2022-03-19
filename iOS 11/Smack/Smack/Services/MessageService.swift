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
    var selectedChannel:Channel?;
    //Check this function!!!
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data
                    else {
                        return;
                }
                let info = String(format: "%02x", Array<UInt8>(response.data.unsafelyUnwrapped));
                print("The current response byte \(info)");
                
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
                //The JSON returned from the server is nil!!!
                if let json = try? JSON(data: data).array
                {
                    print(json.count);
                        for item in json {
                            let name = item["name"].stringValue;
                            let channelDescription = item["description"].stringValue;
                            let id = item["_id"].stringValue;
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id);
                            self.channels.append(channel);
                            print(self.channels[0].channelTitle);
                            
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil);
                        completion(true);
                } else {
                    print("Unable to turn the JSON into Swift array!!!");
                    debugPrint(response.result.error as Any);
                }
                
            } else {
                completion(false);
                debugPrint(response.result.error as Any);
            }
            
        }
        
    }
    
    func clearChannels() {
        channels.removeAll();
    }
}
