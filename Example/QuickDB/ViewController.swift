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

    override func viewDidLoad() {
        super.viewDidLoad()
			//Store model in dataBase
			var myModel = MyModel(name: "ModelName", content: "contentString")
			do {
				try QuickDB.shared.store(model: myModel)
			} catch let error {
				print(error)
			}
//			Retrieve all MyModels
			QuickDB.shared.getAll(LatestObjects: { (items: [MyModel]) in
				print(items)
			}) { (error) in
				print(error)
			}
			
			myModel.name = "NewName"
			do {
				try QuickDB.shared.store(model: myModel)
			} catch let error {
				print(error)
			}
			
			if let image = UIImage(named: "Image"), let data = UIImagePNGRepresentation(image){
				(0...1000).forEach { (index) in
					let imageModel = ImageModel(name: "Image\(index)", data: data)
					do {
						try QuickDB.shared.store(model: imageModel)
					} catch let error {
						print(error)
					}
				}
			}
			
//			Retrieve all ImageModels
			QuickDB.shared.getAll(LatestObjects: { (items: [ImageModel]) in
				print(items)
			}) { (error) in
				print(error)
			}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

