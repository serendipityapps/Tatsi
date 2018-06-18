//
//  LocalizableStrings.swift
//  Tatsi
//
//  Created by Rens Verhoeven on 10/07/2017.
//  Copyright © 2017 Awkward BV. All rights reserved.
//

import Foundation

final internal class LocalizableStrings {
    
    static var bundle: Bundle {
        return Bundle.main
    }
    
    /// The title at the top of the albums view
    static var albumsViewTitle: String {
        return NSLocalizedString("Photos", comment: "The title at the top of the albums view")
    }
    
    /// The title of the back button leading to the albums view
    static var albumsViewBackButton: String {
        return NSLocalizedString("Albums", comment: "The title of the back button leading to the albums view")
    }
    
    /// The title of the header on the albums view
    static var albumsViewMyAlbumsHeader: String {
        return NSLocalizedString("My Albums", comment: "The title of the header on the albums view")
    }
    
    /// The title for the message when the picker has no access to photos
    static var authorizationViewNoAccessTitle: String {
        return NSLocalizedString("Access Denied", comment: "The title for the message when the picker has no access to photos")
    }
    
    /// The message when the picker has no access to photo
    static var authorizationViewNoAccessMessage: String {
        return NSLocalizedString("Please allow access to photos in the Settings app", comment: "The message when the picker has no access to photos")
    }
    
    /// The button on the no access view that leads to the settings in the Settings.app
    static var authorizationViewSettingsButton: String {
        return NSLocalizedString("Open Settings", comment: "The button on the no access view that leads to the settings in the Settings.app")
    }
    
    /// The title for the message when the picker is requesting access to photos
    static var authorizationViewRequestingAccessTitle: String {
        return NSLocalizedString("Requesting Access", comment: "The title for the message when the picker is requesting access to photos")
    }
    
    /// The message when the picker is requesting access to photos
    static var authorizationViewRequestingAccessMessage: String {
        return NSLocalizedString("Tap allow to give access to your photos library", comment: "The message when the picker is requesting access to photos")
    }
    
    /// The title of the empty state when an album is empty
    static var emptyAlbumTitle: String {
        return NSLocalizedString("No Photos", comment: "The title of the empty state when an album is empty")
    }
    
    /// The message of the empty state when an album is empty
    static var emptyAlbumMessage: String {
        return NSLocalizedString("Save some photos to your device", comment: "The message of the empty state when an album is empty")
    }
    
    /// The title of the empty state when the album is loading it's assets
    static var albumLoading: String {
        return NSLocalizedString("Loading...", comment: "The title of the empty state when the album is loading it's assets.")
    }
    
    /// The title of the camera button
    static var cameraButtonTitle: String {
        return NSLocalizedString("Camera", comment: "The title of the camera button")
    }
    
    /// The message that the user is alerted of when the selection limit has been reached
    static var accessibilityAlertSelectionLimitReached: String {
        return NSLocalizedString("The max number of assets has been selected", comment: "The message that the user is alerted of when the selection limit has been reached")
    }
    
}
