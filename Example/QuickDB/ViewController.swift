//
//  ViewController.swift
//  QuickDB
//
//  Created by behrad-kzm on 04/17/2020.
//  Copyright (c) 2020 behrad-kzm. All rights reserved.
//

import UIKit
import QuickDB
class ViewController: UIViewController {
	
	///My model is a Codable and Indexable object. (QuickIndexable Protocol)
	let myModel = MyModel(name: "ModelName", content: "contentString")
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	func useCases(){
				
		///Working With  a Codable Object
				
				//Store myModel in dataBase
				insertMyModel()
				
				//Update myModel in DataBase
				updateMyModel()
				
				//Retrieve all MyModels
				retrieveMyModels()

		///Sample for Saving  an Image
				
				//Insert 1000 ImageModels
				insertImageModels()
				
				//Retrieve all ImageModels
				retrieveImages()
			}
	
}

//MARK: - Working with image
extension ViewController {
	func insertImageModels(){
		if let image = UIImage(named: "Image"), let data = image.pngData(){
			(1...1000).forEach { (index) in
				let imageModel = ImageModel(name: "Image\(index)", data: data)
				QuickDB.shared.insert(model: imageModel)
			}
		}
	}
	
	func retrieveImages(){
		print("\n\nStart getting 1000 images from database at the time of \(Date())")
		QuickDB.shared.getAll(LatestObjects: { (items: [ImageModel]) in
			print(items.count)
			print("\n\nFinished getting 1000 images from database at the time of \(Date())")
		}) { (error) in
			print(error)
		}
	}
}

//MARK: - Working with Codable
extension ViewController {
	func insertMyModel(){
		QuickDB.shared.insert(model: myModel)
	}
	
	func retrieveMyModels(){
		QuickDB.shared.getAll(LatestObjects: { (items: [MyModel]) in
			print(items)
		}) { (error) in
			print(error)
		}
	}
	
	func updateMyModel(){
		var newModel = myModel
		newModel.name = "NewName"
		QuickDB.shared.insert(model: newModel)
	}
	
	func deleteMyModel(){
		QuickDB.shared.delete(ItemIds: [myModel.uid]) { (updated) in
			print("MyModel removed!")
		}
	}
}
