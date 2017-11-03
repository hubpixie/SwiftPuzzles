//
//  ViewController2.swift
//  SwiftPuzzles_ios
//
//  Created by venus.janne on 2017/10/29.
//  Copyright © 2017 venus.janne. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    static let kContentLimitOfPage: Int   = 32
    
    @IBOutlet weak var viewTitleLabel: UILabel!
    @IBOutlet weak var oCollectionView: UICollectionView!
    var defSafeAreaXOffset: CGFloat = 20.0
    var defSafeAreaYOffset: CGFloat = 20.0
    
    fileprivate let collectionDataArray: [String] = {
        var arr: [String] = []
        if let url = Bundle.main.url(forResource:"CollectionData", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let dic = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:[String]]
                arr = dic["DataSource02"]!
                if arr.count > kContentLimitOfPage {
                    arr = Array(arr[arr.startIndex...arr.startIndex + kContentLimitOfPage])
                }
            } catch {
                print(error)
            }
        }
        
        return arr
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.oCollectionView.delegate = self
        self.oCollectionView.dataSource = self
        
        //adjust size for some views
        self.adjustViewLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adjustViewLayout() {
        //adjust size for some views
        let bounds: CGRect = self.view.bounds
        let frame1: CGRect = self.viewTitleLabel.frame
        let frame2: CGRect = self.oCollectionView.frame
        
        if UIScreen.main.nativeBounds.height >= 2436  {
            self.defSafeAreaYOffset = 30
            self.viewTitleLabel.frame = CGRect(x: frame1.origin.x + self.defSafeAreaXOffset, y: frame1.origin.y + self.defSafeAreaYOffset - 20, width: frame1.size.width, height: frame1.size.height)
        } else if UIScreen.main.nativeBounds.height >= 2208 {
            self.viewTitleLabel.frame = CGRect(x: frame1.origin.x + self.defSafeAreaXOffset + 20, y: frame1.origin.y, width: frame1.size.width, height: frame1.size.height)
        } else if UIScreen.main.nativeBounds.height >= 1334 {
            self.viewTitleLabel.frame = CGRect(x: frame1.origin.x + self.defSafeAreaXOffset, y: frame1.origin.y, width: frame1.size.width, height: frame1.size.height)
        } else {
            self.defSafeAreaYOffset = 0.0
        }
        self.oCollectionView.frame = CGRect(x: frame2.origin.x, y: frame2.origin.y, width: frame2.size.width, height: frame2.size.height + (bounds.size.height - frame2.size.height - self.defSafeAreaYOffset))
    }
}

extension ViewController2: UICollectionViewDelegate {
    
}
extension ViewController2: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newLayount: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: newLayount.itemSize.width, height: (self.view.bounds.size.height - 100 - self.defSafeAreaYOffset - 10) / 16);
    }
    
}
extension ViewController2: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PuzzleActionCell", for: indexPath)
        let button: UIButton = cell.viewWithTag(1) as! UIButton
        button.setTitle(self.collectionDataArray[indexPath.item], for: .normal)
        button.addTarget(self, action: #selector(self.tapCellButtonAction(sender:)), for: .touchUpInside)
        return cell
    }
    func tapCellButtonAction(sender: UIButton) {
        guard let indexPath = self.oCollectionView.indexPath(for: sender.superview?.superview as! UICollectionViewCell) else {return}
        
        UIView.animate(withDuration: 0
            , animations: {
                self.oCollectionView.isUserInteractionEnabled = false
                ButtonActions.sharedInstance.performAtIndex(buttonIndex: indexPath.item + ViewController2.kContentLimitOfPage)
        }) { (finish: Bool) in
            DispatchQueue.main.async{
                self.oCollectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    
}
