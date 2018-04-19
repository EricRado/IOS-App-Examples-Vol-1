//
//  AlarmViewController.swift
//  Alarmadillo
//
//  Created by Eric Rado on 4/19/18.
//  Copyright © 2018 Eric Rado. All rights reserved.
//

import UIKit

class AlarmViewController: UITableViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tapToSelectImage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    }
    
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
