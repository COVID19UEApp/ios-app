//
//  TransfersViewController.swift
//  COVID19UE
//
//  Created by Linus Geffarth on 24.03.20.
//  Copyright © 2020 Linus Geffarth. All rights reserved.
//

import UIKit
import OverlayContainer

class TransfersViewController: UIViewController {
    
    @IBOutlet weak var overlayContainerView: UIView!
    let overlayController = OverlayContainerViewController(style: .flexibleHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let mapVC = viewController(withID: "MapViewController", from: "Vendor") as? MapViewController,
            let menuVC = viewController(withID: "TransfersMenuViewController", from: "Vendor") as? TransfersMenuViewController else { return }
        overlayController.delegate = self
        overlayController.viewControllers = [menuVC]
        addChild(overlayController, in: view)
        addChild(mapVC, in: overlayContainerView)
        
        let shouldShowTransferDetails = { transfer in
            self.performSegue(withIdentifier: "Transfers_to_Transfer", sender: transfer)
        }
        mapVC.shouldShowTransferDetails = shouldShowTransferDetails
        menuVC.shouldShowTransferDetails = shouldShowTransferDetails
        menuVC.showOnMap = { transfers in
            mapVC.showOnMap(transfers)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let transfer = sender as? Transfer, let dest = segue.destination.children.first as? TransferViewController {
            dest.transfer = transfer
        }
    }
}

extension TransfersViewController: OverlayContainerViewControllerDelegate {
    enum OverlayNotch: Int, CaseIterable {
        case minimum, maximum
    }
    
    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch OverlayNotch.allCases[index] {
        case .maximum:
            return availableSpace * 0.75
        case .minimum:
            return availableSpace * 0.4
        }
    }
    
    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        OverlayNotch.allCases.count
    }
}
