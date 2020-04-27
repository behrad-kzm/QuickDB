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
	func testResetFactory(){
		let quickData = UIImage(imageLiteralResourceName: "Image").pngData()?.asQuickFile(fileName: "MyImage")
		quickData?.store()
		if let dir = QuickFM.documentPath, let filePath = quickData?.combineFilePath(documentURL: dir).path {
			let fileExist = FileManager.default.fileExists(atPath: filePath)
			if !fileExist{
				XCTAssert(false)
			}
		}
		QuickDB.shared.resetFactory()
		
		if let files = try? FileManager.default.contentsOfDirectory(atPath: QuickFM.documentPath?.path ?? ""){
			print(files)
			XCTAssert(files.count == 0)
			return
		}
		XCTAssert(false)
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
		
		let expectation = XCTestExpectation(description: "Inserting Complex models")
		var retrieveImagesCount = 0
		QuickDB.shared.getAll(LatestObjects: { (items: [ImageModel]) in
			print("\n\nFinished getting \(items.count) images from database at the time of \(Date())")
			XCTAssertEqual(items.count, insertedImagesCount)
			retrieveImagesCount = items.count
			expectation.fulfill()
		}) { (error) in
			print(error)
		}
		
		XCTAssertEqual(retrieveImagesCount, insertedImagesCount, "We should have loaded exactly \(insertedImagesCount) stories.")

	}
	
	//MARK: - Testing duration with complex models
	func testInsertComplexModelsPerformance(){
		
		/////
    let expectation = XCTestExpectation(description: "Inserting Complex models")
    
		let insertedModelsCount = 10 // 10 recursive models
		print("\n\nStart inserting \(insertedModelsCount) complexModels to database at the time of \(Date())")
		insertComplexModels(byCount: insertedModelsCount)
		
		print("\n\nStart getting \(insertedModelsCount) complexModels from database at the time of \(Date())")
		var retrievedModelsCount = 0
		QuickDB.shared.getAll(LatestObjects: { (items: [ComplexModel]) in
			print("\n\nFinished getting \(items.count) complexModels from database at the time of \(Date())")
			XCTAssertEqual(items.count, insertedModelsCount)
			retrievedModelsCount = items.count
			expectation.fulfill()
		}) { (error) in
			print(error)
		}
    
    wait(for: [expectation], timeout: 1.0)
		
		XCTAssertEqual(retrievedModelsCount, insertedModelsCount, "We should have loaded exactly \(insertedModelsCount) stories.")
		/////
		
	}
	
	func testExample() {
		insertComplexModels(byCount: 10)
	}
	
	func insertComplexModels(byCount count: Int){
		(1...count).forEach { (_) in
			let complexModel = ComplexModel(innerItems: (1...count).compactMap{_ in InnerItem(leafs: (1...count).compactMap{_ in Leaf()})})
			QuickDB.shared.insert(model: complexModel)
		}
		
	}
	
	func insertImageModels(byCount count: Int){
		if let image = UIImage(named: "Image"), let data = image.pngData(){
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
