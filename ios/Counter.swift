//
//  Counter.swift
//  nativeModuleIos
//
//  Created by Varun Nath on 23/03/22.
//

import Foundation

@objc(Counter)
class Counter: RCTEventEmitter{
  
  private var count = 0;
  
  @objc
  func increment(_ callback:RCTResponseSenderBlock){
    count += 1;
//    print(count);
    callback([count])
    sendEvent(withName: "onIncrement", body: ["count increase",count])
  }
  
  @objc
  override static func requiresMainQueueSetup() ->Bool{
    return true;
  }
  
  @objc
  override func constantsToExport() -> [AnyHashable: Any]!{
    return ["initialCount": 0];
  }
  
  override func supportedEvents() -> [String]! {
    return ["onIncrement","onDecrement"];
  }
  
  @objc
  func decrement(_ resolve:RCTPromiseResolveBlock,
                 reject:RCTPromiseRejectBlock)
  {
    if(count == 0)
    {
      let error = NSError(domain: "", code: 200, userInfo: nil);
      reject("ERROR_COUNT","count cannot be negative",error);
    }
    else{
      count -= 1; 
      resolve("count is \(count)");
      sendEvent(withName: "onDecrement", body: ["count decrease",count])
    }
  }
  

  

}
