//
//  AddRegistrationTableViewController.swift
//  HotelBooking
//
//  Created by user1 on 11/01/24.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController , selectRoomTypeTableViewControllerDelegate{
    
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        
        self.roomType = roomType
        updateRoomType()
    }
    
    var registration : Registration? {
        guard let roomType = roomType else { return nil }
            
            let firstName = FirstNameTextField.text ?? ""
            let lastName = LastNameTextField.text ?? ""
            let middleName = MiddleNameTextField.text ?? ""
            let checkInDate  = CheckInDateDatePicker.date
            let checkOutDate = CheckOutDateDatePicker.date
            let numberOfAdults = Int(NumberOfAdultsStepper.value)
            let numberOfChildren = Int(NumberOfChildrenStepper.value)
            
            let hasWifi = WifiSwitch.isOn
            
            return Registration(firstName: firstName, lastName: lastName, middleName: middleName, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, wifi: hasWifi, roomType: roomType)
            
        }
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var MiddleNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var CheckInDateLabel: UILabel!
    
    @IBOutlet weak var CheckInDateDatePicker: UIDatePicker!
    
    @IBOutlet weak var CheckOutDateLabel: UILabel!
    
    @IBOutlet weak var CheckOutDateDatePicker: UIDatePicker!
    
    @IBOutlet weak var NumberOfAdultsLabel: UILabel!
    
    @IBOutlet weak var NumberOfAdultsStepper: UIStepper!
    
    @IBOutlet weak var NumberOfChildrenLabel: UILabel!
    
    
    @IBOutlet weak var NumberOfChildrenStepper: UIStepper!
    
    
    @IBOutlet weak var WifiSwitch: UISwitch!
    
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    var roomType : RoomType?
    
    let checkInDatePickerCallIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCallIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDateLabelCallIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCallIndexPath = IndexPath(row: 2, section: 1)

    var  isCheckInDatePickerVisible: Bool = false {
        didSet {
            CheckInDateDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var  isCheckOutDatePickerVisible: Bool = false {
        didSet {
            CheckOutDateDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        CheckInDateDatePicker.minimumDate = midnightToday
        CheckInDateDatePicker.date = midnightToday
        
        updateNumberOfGuests()
        
        updateRoomType()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
//    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePickerCallIndexPath
            where isCheckInDatePickerVisible == false :
            return 0
        case checkOutDatePickerCallIndexPath
            where isCheckOutDatePickerVisible == false :
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePickerCallIndexPath:
            return 190
        case checkOutDatePickerCallIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == checkInDateLabelCallIndexPath && isCheckOutDatePickerVisible == false {
            isCheckInDatePickerVisible.toggle()
        } else if indexPath == 
           checkOutDateLabelCallIndexPath &&
                    isCheckInDatePickerVisible == false {
            isCheckOutDatePickerVisible.toggle()
        } else if indexPath ==
                    checkInDateLabelCallIndexPath || indexPath == checkOutDateLabelCallIndexPath {
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        } else {
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateDateView(){
        
        CheckOutDateDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: CheckInDateDatePicker.date)
        
        CheckInDateLabel.text = CheckInDateDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        CheckOutDateLabel.text = CheckOutDateDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func updateNumberOfGuests(){
        NumberOfAdultsLabel.text = "\(Int(NumberOfAdultsStepper.value))"
        NumberOfChildrenLabel.text = "\(Int(NumberOfChildrenStepper.value))"

    }
    
    func updateRoomType(){
           if let roomType = roomType{
               roomTypeLabel.text = roomType.name
           }
           else{
               roomTypeLabel.text = "Not Set"
           }
       }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker){
        updateDateView()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper){
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchToggle(_ sender: UISwitch){
        
    }
    
    @IBAction func DoneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = FirstNameTextField.text ?? ""
        let middleName = MiddleNameTextField.text ?? ""
        let lastName = LastNameTextField.text ?? ""
        let checkInDate = CheckInDateDatePicker.date
        let checkOutDate = CheckOutDateDatePicker.date
        print(firstName)
        print(middleName)
        print(lastName)
        print(checkInDate)
        print(checkOutDate)
    }
    
    
    @IBSegueAction func SelectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let  selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
                
                selectRoomTypeController?.delegate = self
                selectRoomTypeController?.roomType = roomType
            
                return selectRoomTypeController
       
    }
    
}
