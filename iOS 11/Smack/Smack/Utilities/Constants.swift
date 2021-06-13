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

let BASE_URL = "http://192.168.43.6:3005/v1/"; //CHANGE IT, IF YOUR LOCALHOST DIFFERS!
let URL_REGISTER = "\(BASE_URL)account/register";
let URL_LOGIN = "\(BASE_URL)account/login";
let URL_USER_ADD = "\(BASE_URL)user/add"
// Segues
let TO_LOGIN = "toLogin";
let TO_CREATE_ACCOUNT = "toCreateAccount";
let UNWIND = "unwindToChannel";

// User Defaults
let TOKEN_KEY = "token";
let LOGGED_IN_KEY = "loggedIn";
let USER_EMAIL = "userEmail";

// Headers
let HEADER = ["Content-Type": "application/json; charset=utf-8"];
