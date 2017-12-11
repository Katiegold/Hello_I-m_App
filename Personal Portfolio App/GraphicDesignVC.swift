//
//  GraphicDesignVC.swift
//  Personal Portfolio App
//
//  Created by Katie on 12/2/17.
//  Copyright © 2017 Katie. All rights reserved.
//

import UIKit

class GraphicDesignVC: UIViewController {
    
    struct ImageInformation {
        var image: UIImage
        var fileName: String!
        var description: String!
    }
    
    let defaultsData = UserDefaults.standard
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagePicker = UIImagePickerController()
    var structArray = [ImageInformation]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        //collectionView.reloadData()
        readData()
    }

    //MARK: problems: let document was supposed to be a string, but it didn't show up as one, so I had to force it
    
    func writeData(image: UIImage) {
        if let imageData = UIImagePNGRepresentation(image) {
            let fileName = NSUUID().uuidString
            let documents = String(describing: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
            let writePath = documents.appending(fileName)
            do {
                try imageData.write(to: URL(fileURLWithPath: writePath))
                structArray.append(ImageInformation(image: image, fileName: fileName, description: ""))
                let urlArray = structArray.map {$0.fileName!}
                defaultsData.set(urlArray, forKey: "photoURLs")
                collectionView.reloadData()
            } catch {
                print("error in trying to write imageData for url \(writePath)")
            }
        } else {
            print("error trying to convert image into a raw data file")
        }
    }
    
    func readData() {
        if let urlArray = defaultsData.object(forKey: "photoURLs") as? [String] {
            for index in 0..<urlArray.count {
                let fileManager = FileManager.default
                let fileName = urlArray[index]
                let documents = String(describing: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
                let readPath = documents.appending(fileName)
                if fileManager.fileExists(atPath: readPath){
                    let newImage = UIImage(contentsOfFile: readPath)!
                    structArray.append(ImageInformation(image: newImage, fileName: fileName, description: ""))
                } else {
                    print("error: no file exists at read path")
                }
            }
            collectionView.reloadData()
        } else {
            print("Error reading in defaults data")
        }
    }
    
    @IBAction func photoLibButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    

}
extension GraphicDesignVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return structArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let graphicCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphicCell", for: indexPath) as! GraphicCell
        //graphicCell.update(with: "", timeZone: "")
        graphicCell.graphicView.image = structArray[indexPath.row].image
        return graphicCell
    }
}
extension GraphicDesignVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        if let selectedImage = selectedImage {
            //structArray.append(ImageInformation(image: selectedImage, fileName: "", description: ""))
            dismiss(animated: true, completion: {self.writeData(image: selectedImage)})
        }
        //collectionView.reloadData()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}













