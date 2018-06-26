//
//  UIViewController+Helpers.swift
//  TastefulBeers
//
//  Created by Vitor Rodrigues on 6/25/18.
//  Copyright © 2018 Vitor Rodrigues. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private static let loadingTag: Int = 944
    func showLoading() {
        // Check if loading is already on screen
        guard view.viewWithTag(UIViewController.loadingTag) == nil else { return }
        
        let loadingVc = VRLoadingView.instance
        loadingVc.tag = UIViewController.loadingTag
        loadingVc.show(in: view)
    }
    var isLoadingShowing: Bool {
        return view.viewWithTag(UIViewController.loadingTag) != nil
    }
    
    func hideLoading() {
        view.viewWithTag(UIViewController.loadingTag)?.removeFromSuperview()
    }
    
    func showError(_ error: Error) {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            if nsError.code == NSURLErrorCancelled { return }
            // Connection-related errors
            handleUrlError(nsError, in: self)
        } else {
            // Generic Error
            showBasicAlert(title: "Error",
                           message: error.localizedDescription,
                           buttonText: "Close",
                           handler: nil)
        }
    }
    
    func showBasicAlert(title: String?, message: String?, buttonText: String, handler: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        
        let close = UIAlertAction(title: buttonText, style: .cancel, handler: handler)
        alert.addAction(close)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - NSURL errors
    // All common handled errors should be localized
    private func handleUrlError(_ error: NSError,in vc: UIViewController) {
        var message: String!
        var title = "Connection error"
        
        switch error.code {
        case NSURLErrorNotConnectedToInternet:
            title = "You're disconnected"
            message = "Try again when you have some connection to the internet"
        case NSURLErrorTimedOut:
            title = "Timeout"
            message = "This request took too long, so we've lost it"
        case NSURLErrorNetworkConnectionLost:
            title = "Connection lost!"
            message = "The connection to the internet was lost or resetted"
        default:
            message = "There was an unexpected error"
        }
        
        vc.showBasicAlert(title: title,
                          message: message,
                          buttonText: "Close",
                          handler: nil)
    }
}
