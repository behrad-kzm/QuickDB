import XCTest
import QuickDB

class Tests: XCTestCase {
	
	var codableObject: SimpleCodable!
	override func setUp() {
		super.setUp()
		QuickDB.shared.resetFactory()
		codableObject = SimpleCodable(name: "TestName", content: "TestContent")
		
	}
	
	override func tearDown() {
		super.tearDown()
		QuickDB.shared.resetFactory()
		codableObject = nil
	}
	
	//MARK: - Test Updating Model
	func testDeletingModel(){
		QuickDB.shared.insert(model: codableObject)
		QuickDB.shared.delete(ItemIds: [codableObject.uid]) { [unowned self](updated) in
			if updated {
				QuickDB.shared.get(ItemWithId: self.codableObject.uid, response: { (item: SimpleCodable) in
					XCTAssert(false)
				}) { (error) in
					if CoreDataError.isEmpty.localizedDescription == error.localizedDescription {
						XCTAssert(true)
						return
					}
					XCTAssert(false)
				}
				return
			}
			XCTAssert(false)
		}
	}
	
	//MARK: - Test Updating Model
	func testUpdatingModel(){
		QuickDB.shared.insert(model: codableObject)
		
		let updatingName = UUID().uuidString
		var newModel = codableObject!
		newModel.name = updatingName
		
		QuickDB.shared.update(model: newModel, completion: { (updated) in
			QuickDB.shared.get(ItemWithId: newModel.uid, response: { (item: SimpleCodable) in
				XCTAssertEqual(item.name, updatingName)
			}) { (_) in
				XCTAssert(false)
			}
		}) { (_) in
			XCTAssert(false)
		}
	}
	
	//MARK: - Testing duration with large models
	func testInsertImageModels(){
		
		let insertedImagesCount = 1000
		
		insertImageModels(byCount: insertedImagesCount)
		
		print("\n\nStart getting 1000 images from database at the time of \(Date())")
		
		let exp = expectation(description: "Test after 5 seconds")
		let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
		var retrieveImagesCount = 0
		QuickDB.shared.getAll(LatestObjects: { (items: [ImageModel]) in
			print("\n\nFinished getting \(items.count) images from database at the time of \(Date())")
			retrieveImagesCount = items.count
			exp.fulfill()
		}) { (error) in
			print(error)
		}
		
		if result == XCTWaiter.Result.timedOut {
			XCTAssertEqual(retrieveImagesCount, insertedImagesCount)
		} else {
			XCTFail("Delay interrupted")
		}
	}
	
	
	func insertImageModels(byCount count: Int){
		if let image = UIImage(named: "Image"), let data = UIImagePNGRepresentation(image){
			(1...count).forEach { (index) in
				let imageModel = ImageModel(name: "Image\(index)", data: data)
				QuickDB.shared.insert(model: imageModel)
			}
		}
	}
	
	func deleteMyModel(){
		QuickDB.shared.delete(ItemIds: [codableObject.uid]) { (updated) in
			XCTAssert(updated)
		}
	}
}
