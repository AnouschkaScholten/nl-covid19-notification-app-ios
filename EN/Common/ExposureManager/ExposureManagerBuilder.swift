/*
* Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
*  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
*
*  SPDX-License-Identifier: EUPL-1.2
*/

#if canImport(ExposureNotification)
import ExposureNotification
#endif
import Foundation
import UIKit

enum ExposureManagerAuthorisationStatus {
    case active
    case inactive(ExposureManagerError)
}

enum ExposureManagerError: Error {
    case unknown
    case disabled
    case bluetoothOff
    case restricted
    case notAuthorized
}

/// @mockable
protocol ExposureManaging {
    // MARK: - Activation
    
    /// Activates the ExposureManager - Should be the first call to execute. The framework
    /// might be usable until an active state is returned
    func activate(completion: @escaping (ExposureManagerAuthorisationStatus) -> Void)
    
    /// Detects exposures from a given set of exposure key URLs.
    /// A summary is returned when a match is found. If no summary is returned
    /// no match has been found
    func detectExposures(diagnosisKeyURLs: [URL],
                         completion: @escaping (Result<ExposureDetectionSummary?, ExposureManagerError>) -> Void)
    
    /// Returns this device's diagnosis keys
    func getDiagnonisKeys(completion: @escaping (Result<[DiagnosisKey], ExposureManagerError>) -> Void)
    
    /// Enabled exposure notifications. Successful when completion is
    /// called without an error
    func setExposureNotificationEnabled(_ enabled: Bool, completion: @escaping (Result<(), ExposureManagerError>) -> Void)
    
    /// Returns whether exposure notifications are enabled
    func isExposureNotificationEnabled() -> Bool
    
    /// Returns the current authorisation status
    func getExposureNotificationAuthorisationStatus() -> ExposureManagerAuthorisationStatus
}

/// @mockable
protocol ExposureManagerBuildable {
    /// Builds an ExposureManager instance.
    /// Returns nil if the OS does not support Exposure Notifications
    func build() -> ExposureManaging?
}

final class ExposureManagerBuilder: Builder<EmptyDependency>, ExposureManagerBuildable {
    
    func build() -> ExposureManaging? {
        if #available(iOS 13.5, *) {
            #if targetEnvironment(simulator)
            return StubExposureManager()
            #else
            return ExposureManager(manager: EMManager())
            #endif
        }
        
        return nil
    }
    
    
}