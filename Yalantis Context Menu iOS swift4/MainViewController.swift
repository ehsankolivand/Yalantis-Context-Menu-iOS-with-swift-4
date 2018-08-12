//
//  ViewController.swift
//  Yalantis Context Menu iOS swift4
//
//  Created by ehsan kolivand on 8/12/18.
//  Copyright © 2018 ehsan kolivand. All rights reserved.
//

import UIKit
let menuCellIdentifier = "rotationCell"

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YALContextMenuTableViewDelegate {
  
    
    var menuTitles : [String?] = []
    var menuIcons : [UIImage?] = []
    var contextMenuTableView: YALContextMenuTableView?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let t = tableView as! YALContextMenuTableView
        let cell = t.dequeueReusableCell(withIdentifier: menuCellIdentifier, for:indexPath) as! ContextMenuCell
        
        cell.backgroundColor = UIColor.clear
        cell.menuTitleLabel.text = self.menuTitles[indexPath.row]
        cell.menuImageView.image = self.menuIcons[indexPath.row]
        
        
        return cell;
    }
    
    func initiateMenuOptions() {
        self.menuTitles = ["",
                           "Send message",
                           "Like profile",
                           "Add to friends",
                           "Add to favourites",
                           "Block user"]
        
        self.menuIcons = [UIImage(named: "Icnclose"), UIImage(named: "SendMessageIcn"), UIImage(named: "LikeIcn"), UIImage(named: "AddToFriendsIcn"), UIImage(named: "AddToFavouritesIcn"), UIImage(named: "BlockUserIcn")]
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil, completion: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.contextMenuTableView!.reloadData()
        })
        
        self.contextMenuTableView!.updateAlongsideRotation()

    }
    
    
    @IBAction func clickedmenu(_ sender: Any) {
        
        // init YALContextMenuTableView tableView
        self.contextMenuTableView = YALContextMenuTableView(tableViewDelegateDataSource: self)
        self.contextMenuTableView!.animationDuration = 0.11;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView!.yalDelegate = self
        let cellNib = UINib(nibName: "ContextMenuCell", bundle: nil)
        self.contextMenuTableView?.register(cellNib, forCellReuseIdentifier: menuCellIdentifier)
        
        // it is better to use this method only for proper animation
        self.contextMenuTableView?.show(in: self.navigationController!.view, with: UIEdgeInsets.zero, animated: true)

    }
    func contextMenuTableView(_ contextMenuTableView: YALContextMenuTableView!, didDismissWith indexPath: IndexPath!) {
        print("Menu dismissed with indexpath = \(indexPath)")
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let t = tableView as! YALContextMenuTableView
        t.dismis(with: indexPath)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initiateMenuOptions()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

