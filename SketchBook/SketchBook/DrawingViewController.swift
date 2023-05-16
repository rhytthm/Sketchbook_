//
//  DrawingViewController.swift
//  SketchBook
//
//  Created by Rhytthm Mahajan on 19/02/23.
//

import UIKit
import PencilKit

class DrawingViewController: UIViewController , PKCanvasViewDelegate, PKToolPickerObserver{
    
    @IBOutlet weak var canvas: PKCanvasView!
    var delegate: ViewControllerDelegate?
    var index:Int = 0
    
    var drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.delegate = self
        canvas.becomeFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        canvas.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        canvas.drawingPolicy = .anyInput
        setupCanvas()
    }
    
    private func setupCanvas(){
        toolPicker.addObserver(canvas)
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
    }
    
    public func setup(drawing:PKDrawing, index:Int){
        self.drawing = drawing
        self.index = index
    }
    
    @IBAction func Save(_ sender: Any) {
        let image = drawing.image(from: canvas.drawing.bounds, scale: 1.0)
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        delegate?.saveDrawing(drawing: canvas.drawing , index: index)
    }
    
    @IBAction func Clear(_ sender: Any) {
        canvas.drawing = PKDrawing()
    }

    func snapshot(from canvas: PKCanvas) -> UIImage {
        //Take PencilKit Drawings snapshot
        return UIImage()
    }
    
    // Canvas delegate Methods
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        self.drawing = canvas.drawing
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("End using the PK tools")
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("Completed the UI Event")
    }
}
