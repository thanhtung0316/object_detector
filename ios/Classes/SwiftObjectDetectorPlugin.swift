import Flutter
import UIKit
import MediaPipeTasksVision

public class SwiftObjectDetectorPlugin: NSObject, FlutterPlugin {
    
   static var registrar: FlutterPluginRegistrar?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    self.registrar = registrar
    let channel = FlutterMethodChannel(name: "object_detector", binaryMessenger: registrar.messenger())
    let instance = SwiftObjectDetectorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let args = call.arguments as? [String]
      guard let assetPath = args?.first else{
          print("Model path is empty")
          return
      }
      guard let imagePathArg = args?.last else{
          print("imagePath is empty")
          return
      }
      
      let modelKey = SwiftObjectDetectorPlugin.registrar?.lookupKey(forAsset: assetPath)
      let imageKey = SwiftObjectDetectorPlugin.registrar?.lookupKey(forAsset: imagePathArg)
      let mainBundle = Bundle.main
      print("modelKey: ", modelKey)
      guard let modelPath = mainBundle.path(forResource: modelKey, ofType: nil) else{
          print("Model path is empty")
          return
      }
      guard let uiImage = UIImage(contentsOfFile: imagePathArg) else{
          print("uiImage is empty")
          return
      }
      guard let image = try? MPImage(uiImage: uiImage) else{
          print("image is empty")
          return
      }
    
      let options = ObjectDetectorOptions()
      options.baseOptions.modelAssetPath = modelPath
      options.runningMode = .image
      do {
          let objectDetector = try ObjectDetector(options: options)
        let results = try objectDetector.detect(image: image)
          var objectList: [Any] = []
          for detection in results.detections {
              for cate in detection.categories{
                  let object:[String: Any] = [
                    "score":cate.score,
                    "categoryName":cate.categoryName,
                    "boundingBox":[
                        "x":detection.boundingBox.minX,
                        "y":detection.boundingBox.minY,
                        "w":detection.boundingBox.width,
                        "h":detection.boundingBox.height,
                                  ]
                  ]
                  objectList.append(object)
              }
          }
          var data : [Int:Any] = [:]
          for i in (0..<objectList.count){
              data[i] = objectList[i]
          }
          result(data)
      } catch {
          print("catchhh")
      }
     
      result("Not found")
  }
}
