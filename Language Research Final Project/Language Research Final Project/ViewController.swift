//
//  ViewController.swift
//  Language Research Final Project
//
//  Created by Byeongyun Goo on 2019-02-09.
//  Copyright © 2019 Byeongyun Goo. All rights reserved.
//

import UIKit

/// ViewController that directly connects to user interface
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    // UILable for my name
    @IBOutlet weak var labelMyName: UILabel!
    
    // UITextField for add/edit data
    @IBOutlet weak var textFieldAdd: UITextField!
    
    // UIPickerView to give user to pick which data want to edit/delete
    @IBOutlet weak var PickerViewList: UIPickerView!
    // Empty string array to store data
    var pickerData: [String] = [String]()
    
    // UITextView for all data
    @IBOutlet weak var textViewDataSet: UITextView!

    // Empty string for datainput from user
    var dataInput : String = ""
    
    // Delcare UserDefaults to store data
    var defaults = UserDefaults.standard
    
    // Empty string for data array
    var dataArray : [String] = []
    
    // Empty string for defaultsArray for the UserDefaults
    var defaultsArray : [String] = []
  
    
    // Button for the user side with addFunc()
    @IBAction func buttonAdd(_ sender: Any) {
        addFunc()
    }
 
    // Button for the user side with editFunc()
    @IBAction func buttonEdit(_ sender: Any) {
        editData()
    }
    
    // Button for the user side with deleteFunc()
    @IBAction func buttonDelete(_ sender: Any) {
        deleteData()
    }
    
    
    // Button for the user side with loadCSV()
    @IBAction func buttonLoadCSV(_ sender: Any) {
        loadCSV()
    }
    
    // Button for the user side with deleteDataAll()
    @IBAction func buttonDeleteAll(_ sender: Any) {
        deleteDataAll()
    }

    // Button for the user side with dataDesc()
    @IBAction func buttonDesc(_ sender: Any) {
        dataDesc()
    }
    
    // Button for the user side with dataAsc()
    @IBAction func buttonAsc(_ sender: Any) {
        dataAsc()
    }
    
    
    /**
     Function to add data to array, reload PickerViewList, and updating list of data
     */
    func addFunc(){
        
        // Tarking data from textField to dataInput that it's declared
        dataInput = textFieldAdd.text!
        // Append data with the user input
        defaultsArray.append(dataInput)
        defaultUserFunc()
    }
    

    /**
     Function to edit data to array, reload PickerViewList, and updating list of data
     */
    func editData() {
        // Finding which data user is looking for and switch to data from user input
        defaultsArray[listNum] = textFieldAdd.text!
        defaultUserFunc()
    }
    
    
    /**
     Function to delete data to array, reload PickerViewList, and updating list of data
     */
    func deleteData() {
        // Finding which data user is looking for and delete the data
        defaultsArray.remove(at: listNum)
        defaultUserFunc()
    }
    
    
    /**
     Function to delete all list
     */
    func deleteDataAll() {
        defaultsArray.removeAll(keepingCapacity: false)
        defaultUserFunc()
    }
    
    
    /**
     Store all data user parses from csv file
     */
    func dataDesc(){
        // Reverse the array; descendence
        defaultsArray = Array(defaultsArray.sorted().reversed())
        defaultUserFunc()
    }
    
    
    /**
     Store all data user parses from csv file
     */
    func dataAsc() {
        // Sorted the array; ascendance
        defaultsArray = Array(defaultsArray.sorted())
        defaultUserFunc()
    }
    

    /**
     Redundant functions for defaultsUser
     */
    func defaultUserFunc() {
        // Reset all data for new defaultUser data
        defaults.removeObject(forKey: "DataListArray")
        // Add a new dataset to the defaultUser
        defaults.set(defaultsArray, forKey: "DataListArray")
        // Synchronize to make sure all it's stored
        defaults.synchronize()
        // Reload all list for user in real time once data's added
        PickerViewList.reloadAllComponents()
        textViewDataSet.text = defaultsArray.joined(separator:"\n")
    }
    
    
    /**
     Store all data user parses from csv file
     */
    func loadCSV() {
        
        // Set a file name and type
        var data = readDataFromCSV(fileName: "Quttinirpaaq_NP_Tundra_Plant_Phenology_2016-2017_data_1", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        // Append 10 rows of data from the scv file
        dataSetStoredFromCSVString.append(csvRows[2].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[3].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[4].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[5].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[6].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[7].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[8].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[9].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[10].joined(separator:","))
        dataSetStoredFromCSVString.append(csvRows[11].joined(separator:","))
        
        // Use for loop to determine even number of arrays with stride
        for i in stride(from: 0, to: dataSetStoredFromCSVString.count, by: 1) {
            
            // Print even number of arrays for the console window
            print((dataSetStoredFromCSVString[i]))
            // Store sorted data into empty string array
            defaultsArray.append(dataSetStoredFromCSVString[i])
            }
        
        // Make sure remove all data in the array
        dataSetStoredFromCSVString.removeAll(keepingCapacity: false)
        defaultUserFunc()
        
        }
    

    /**
     Read data from csv file
     */
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        // Get a filepath to check the file exists
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            // Parse data from the file in specific encoding type
            var contents = try String(contentsOfFile: filepath, encoding: String.Encoding.ascii)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }


    /**
     Clean each row
     - Parameter file: parsed data from the csv file
     - returns: return reorganized string
     */
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }


    /**
     Store all data I parse from csv
     - Parameter data: parsed data from the csv file
     - returns: data with array String
     */
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        // Each row will be saved in 'result' array
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }

    
    // Empty int list number to keep updating list number from the pickerView
    var listNum : Int = 0

    // Declare an empty string array to store sorted array
    var dataSetSorted = [String]()
    
    // Declare an empty array from csv as string
    var dataSetStoredFromCSVString = [String]()
    
    // Declear an empty string to store String from string array for display in GUI
    var displayString = ""
    
    // Set my name as string
    let myName : String = "Byeongyun Goo"

    /**
     This method is called after viewController.swift is loaded
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data to delegate for the PickerViewList
        self.PickerViewList.delegate = self
        
        // Connect data to DataSouce for the PickerViewList
        self.PickerViewList.dataSource = self
        self.defaultsArray = defaults.stringArray(forKey: "DataListArray") ?? [String]()
    
        // Use a joined to convert from String array to String in order to use textViewDataSet for mobile GUI
        displayString = defaultsArray.joined(separator:"\n")
    
        // Display the sorted list on GUI
        textViewDataSet.text = displayString
        }
    
        /**
         Number of columns of data for the pickerView
         - Parameter pickerView: UIPickerView
         - returns: 1
         */
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        /**
         The number of rows of data for the pickerView
         - Parameter pickerView: UIPickerView
         - Parameter component: the number of Row in the component
         - returns: the number of the data array
        */
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            print("defaultsArray.count", defaultsArray.count)
            return defaultsArray.count
        }
    
        /**
         The data to return for the row and component (column) that's being passed in
         - Parameter pickerView: UIPickerView
         - Parameter row: the title for row
         - Parameter component: the component
         - returns: The number of the row
         */
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            textFieldAdd.text = defaultsArray[row]
            listNum = row
            return defaultsArray[row]
        }
    
}
