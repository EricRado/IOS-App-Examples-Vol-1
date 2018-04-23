//
//  AlarmViewController.swift
//  Alarmadillo
//
//  Created by Eric Rado on 4/19/18.
//  Copyright © 2018 Eric Rado. All rights reserved.
//

import UIKit

class AlarmViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tapToSelectImage: UILabel!
    
    var alarm: Alarm!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = alarm.name
        name.text = alarm.name
        caption.text = alarm.caption
        datePicker.date = alarm.time
        
        if alarm.image.count > 0 {
            // if we have an image, try to load it
            let imageFilename = Helper.getDocumentsDirectory().appendingPathComponent(alarm.image)
            imageView.image = UIImage(contentsOfFile: imageFilename.path)
            tapToSelectImage.isHidden = true
        }
    }
    
    @objc func save() {
        NotificationCenter.default.post(name: Notification.Name("save"), object: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        alarm.time = datePicker.date
        save()
    }
    
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 1: dismiss the image picker
        dismiss(animated: true)
        
        // 2: fetch the image that was picked
        guard let image = info[UIImagePickerControllerOriginalImage]
            as? UIImage else {return}
        let fm = FileManager()
        
        if alarm.image.count > 0 {
            // 3: the alarm already has an image, so delete it
            do {
                let currentImage = Helper.getDocumentsDirectory().appendingPathComponent(alarm.image)
                if fm.fileExists(atPath: currentImage.path) {
                    try fm.removeItem(at: currentImage)
                }
            }catch {
                print("Failed to remove current image")
            }
        }
        
        do {
            // 4: Generate a new filename for the image
            alarm.image = "\(UUID().uuidString).jpg"
            
            // 5: write the new image to the documents directory
            let newPath = Helper.getDocumentsDirectory().appendingPathComponent(alarm.image)
            let jpeg = UIImageJPEGRepresentation(image, 80)
            try jpeg?.write(to: newPath)
            save()
        }catch {
            print("Failed to save new image")
        }
        
        // 6: update the user interface
        imageView.image = image
        tapToSelectImage.isHidden = true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        alarm.name = name.text!
        alarm.caption = caption.text!
        title = alarm.name
        save()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
