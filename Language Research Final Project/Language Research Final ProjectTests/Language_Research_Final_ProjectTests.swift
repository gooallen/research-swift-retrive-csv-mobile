//
//  Language_Research_Final_ProjectTests.swift
//  Language Research Final ProjectTests
//
//  Created by Byeongyun Goo on 2019-02-10.
//  Copyright © 2019 Byeongyun Goo. All rights reserved.
//

import XCTest
@testable import Language_Research_Final_Project

class Language_Research_Final_ProjectTests: XCTestCase {

    // Declare ViewController
    var testForAdd : ViewController!
   
    /**
     This method is called before the invocation of each test method in the class.
     */
    override func setUp()
    {
        super.setUp()
        // Declare UIStoryboard to instantiate ViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
 
        // Declare ViewController with matching 'withIdentifier' in order to make same environment for the test
        let vc: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        testForAdd = vc
        
        // Call the viewSidLoad
        _ = testForAdd.view
    }
    
    /**
     A new record is added to the end of the array or list?
     */
    func testSortedArray() {
        // Call the loadCSV()
        testForAdd.loadCSV()
        // Call the dataDesc() to test the function works properly
        testForAdd.dataDesc()
        // Test with XCTAssertEqual method
        XCTAssertEqual(testForAdd.defaultsArray[0], "Dryas integrifolia,2016,196,1,0,0,31,LP,", "Check the first array which is the last array before dataReverse()")
    }
}
