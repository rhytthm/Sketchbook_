//
//  ViewController.swift
//  SketchBook
//
//  Created by Rhytthm Mahajan on 19/02/23.
//

import UIKit
import PencilKit

protocol ViewControllerDelegate {
    func saveDrawing(drawing:PKDrawing?, index:Int?)
    func saveImage(image:UIImage?)
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ViewControllerDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    var number = 1
    var dataList: [UIImage?] = []
    var drawingList: [PKDrawing?] = []
    var minusSelected = false
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        initiate()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            print(indexPath.row)
            cellItem.configure(with: dataList[indexPath.row])
            
            cell = cellItem
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  minusSelected{
            number-=1
            dataList.remove(at: indexPath.row)
            self.collectionView.reloadData()
        }else{
            print("Cell \(indexPath.row + 1) clicked")
            guard let vc = storyboard?.instantiateViewController(identifier: "DrawingViewController") as? DrawingViewController else {return}
            vc.delegate = self
            if let drawing = drawingList[indexPath.row]{
                vc.setup(drawing: drawing, index: indexPath.row)
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func initiate(){
        for _ in 0...number{
            let image = UIImage()
            let drawing = PKDrawing()
            dataList.append(image)
            drawingList.append(drawing)
        }
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        number += 1
        let image = UIImage()
        dataList.append(image)
        self.collectionView.reloadData()

    }
    
    @IBAction func minusTapped(_ sender: UIButton) {
        minusSelected.toggle()
        if minusSelected{
            textView.text = "Selected"
            
        }else{
            textView.text = ""
        }
        
    }
    
    func saveDrawing(drawing: PKDrawing?, index: Int?) {
        if let index = index {
            self.drawingList.insert(drawing, at: index)
        }
    }
    
    func saveImage(image: UIImage?) {
        
    }
    
}

