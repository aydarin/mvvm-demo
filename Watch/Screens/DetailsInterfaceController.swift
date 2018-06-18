//
//  DetailsInterfaceController.swift
//  MVVMDemo
//
//  Created by Aydar Mukhametzyanov on 6/17/18.
//  Copyright © 2018 Aydar Mukhametzyanov. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class DetailsInterfaceController: WKInterfaceController {
    @IBOutlet private var nameLabel: WKInterfaceLabel!
    @IBOutlet private var descriptionLabel: WKInterfaceLabel!
    @IBOutlet private var voteButton: WKInterfaceButton!
    
    private var session: WCSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let planet = context as? Planet else {
            return
        }
        
        nameLabel.setText(planet.name)
        descriptionLabel.setText(planet.description)
        voteButton.setEnabled(false)
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            
            if session?.activationState != .activated {
                session?.activate()
            } else {
                voteButton.setEnabled(true)
            }
        }
    }
    
    var count = 0
    
    @IBAction private func votePressed() {
        try? session?.updateApplicationContext(["message": "Hello, app! \(count)"])
        count += 1
    }

}

extension DetailsInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("watch: activation completed: \(error)")
        voteButton.setEnabled(activationState == .activated)
    }
}
