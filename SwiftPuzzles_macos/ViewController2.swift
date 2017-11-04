//
//  ViewController2.swift
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/06/05.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import Cocoa

class ViewController2: NSViewController {
    
    @IBOutlet weak var oCollectionView: NSCollectionView!
    fileprivate var isButtonInUse: Bool = false
    fileprivate let collectionDataArray: [String] = {
        var arr: [String] = []
        if let url = Bundle.main.url(forResource:"CollectionData", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let dic = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:[String]]
                arr = dic["DataSource02"]!
                if arr.count > 32 {
                    arr = Array(arr[arr.startIndex...arr.startIndex+32])
                }
            } catch {
                print(error)
            }
        }
        
        return arr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.oCollectionView.register(NSNib(nibNamed: NSNib.Name(rawValue: "PuzzleActionCellX"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PuzzleActionCellX"))
        self.oCollectionView.dataSource = self
        self.oCollectionView.delegate = self
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}

extension ViewController2: NSCollectionViewDelegate {
    
}

extension ViewController2: NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    // 2
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataArray.count
    }
    
    // 3
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // 4
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PuzzleActionCellX"), for: indexPath)
        
        guard let collectionViewItem = item as? PuzzleActionCellX else {return item}
        
        // 5
        collectionViewItem.oDefButton.title  = self.collectionDataArray[indexPath.item]
        //collectionViewItem.oDefButton.addTarget(self, action: #selector(self.tapCellButtonAction(sender:)), for: .touchUpInside)
        collectionViewItem.oDefButton.tag = indexPath.item + 32
        collectionViewItem.oDefButton.action = #selector(self.tapCellButtonAction(sender:))
        collectionViewItem.oDefButton.target = self

        return item
    }
    
    @objc func tapCellButtonAction(sender: NSButton) {
        let indexPath: NSIndexPath = NSIndexPath(forItem: sender.tag, inSection: 0)
        NSAnimationContext.runAnimationGroup({_ in
            //Indicate the duration of the animation
            NSAnimationContext.current.duration = 3.0
            //What is being animated? In this example I’m making a view transparent
            self.oCollectionView.animator().alphaValue = 0.5
            self.oCollectionView.disableSubViews(target: nil)
            ButtonActions.sharedInstance.performAtIndex(buttonIndex: indexPath.item)
        }, completionHandler:{
            //In here we add the code that should be triggered after the animation completes.
            DispatchQueue.main.async{
                self.oCollectionView.animator().alphaValue = 1.0
                self.oCollectionView.enableSubViews(target: self)
            }
        })
    }
    
}



