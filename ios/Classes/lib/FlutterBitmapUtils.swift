//
//  FlutterBitmapUtils.swift
//  awesome_notifications
//
//  Created by CardaDev on 03/02/22.
//

import Flutter
import Foundation

@available(iOS 10.0, *)
public class FlutterBitmapUtils : BitmapUtils {
    
    let registrar:FlutterPluginRegistrar?
    
    public init(registrar:FlutterPluginRegistrar?) {
        self.registrar = registrar
        super.init()
    }
    
    public static func extendCapabilities(usingFlutterRegistrar registrar:FlutterPluginRegistrar?){
        BitmapUtils.instance = FlutterBitmapUtils(registrar: registrar)
    }
    
    open override func getBitmapFromAsset(_ mediaPath:String) -> UIImage? {
        
        let mediaPath:String? = cleanMediaPath(mediaPath)

        if(StringUtils.shared.isNullOrEmpty(mediaPath)){ return nil }
                
        var topPath:String?
        if registrar != nil {
            let key = registrar!.lookupKey(forAsset: mediaPath!)
            topPath = Bundle.main.path(forResource: key, ofType: nil)
        }
        
        if SwiftUtils.isRunningOnExtension() && topPath?.isEmpty ?? true {
            topPath = SwiftUtils.getFlutterAssetPath(forAsset: mediaPath!)
        }
        
        return topPath == nil ? nil : getBitmapFromFile(fromRealPath: topPath!)
    }
}
