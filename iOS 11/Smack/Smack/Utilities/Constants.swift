//
//  Constants.swift
//  Smack
//
//  Created by robot on 4/30/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ();

// URL constants

let BASE_URL = "http://185.17.2.188:3005/v1/"; //CHANGE IT, IF YOUR LOCALHOST DIFFERS!
let URL_REGISTER = "\(BASE_URL)account/register";
let URL_LOGIN = "\(BASE_URL)account/login";
let URL_USER_ADD = "\(BASE_URL)user/add";
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/";
let URL_GET_CHANNELS = "\(BASE_URL)channel/";

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5);

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged");
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded");
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected");
// Segues
let TO_LOGIN = "toLogin";
let TO_CREATE_ACCOUNT = "toCreateAccount";
let UNWIND = "unwindToChannel";
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token";
let LOGGED_IN_KEY = "loggedIn";
let USER_EMAIL = "userEmail";

// Headers
let HEADER = ["Content-Type": "application/json; charset=utf-8"];

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
