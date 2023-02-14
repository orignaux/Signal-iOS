//
// Copyright 2023 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import Foundation

public enum RegistrationStep: Equatable {

    // MARK: - Opening Steps
    case splash
    case permissions

    // MARK: - Actually registering

    /// The user should enter or confirm their phone number.
    /// The number may be pre-filled or empty; either way we will require
    /// the user to confirm the number at least once before proceeding.
    /// The number may be used to send an SMS or as a way to identify the
    /// account being registered for via KBS backup info.
    /// TODO[Registration]: define the view model struct to be passed here,
    /// which should include error state if the phone number is invalid or rejected.
    case phoneNumberEntry

    /// If registering via session, the step to enter the verification code.
    /// TODO[Registration]: define the view model struct to be passed here,
    /// which should include error state if the code is invalid or rejected.
    case verificationCodeEntry

    /// When registering, the server can inform the client that a device-to-device
    /// transfer is possible. If so, the user must either do the transfer, or explicitly
    /// elect not to. This step presents those options to the user.
    /// Only happens if registering on a new device without local data.
    case transferSelection

    /// For the first time we enter the pin. This can be
    /// for first account setup, creating a pin, or if
    /// re-registering and needing to confirm the pin.
    /// When doing first time setup, the pin must be confirmed; that is
    /// considered part of this same "step" and is just a UI detail.
    /// TODO[Registration] Differentiate those cases via an associated value.
    case pinEntry

    /// At _any_ point during session-based registration, a captcha challenge may be
    /// requested.
    /// TODO[Registration] define the view model to be passed here.
    case captchaChallenge

    // MARK: - Post-Registration

    /// If the account has not set whether its phone number should be
    /// discoverable, this step happens after registration is complete.
    /// (Typically skipped during re-registration as a result.)
    case phoneNumberDiscoverability

    /// If the account has not set profile info, this step happens after registration is complete.
    /// (Typically skipped during re-registration as a result.)
    case setupProfile

    // MARK: - Non-ViewController steps

    /// Special cases; should display an error on the current screen, whatever it is.
    /// (If this is returned as the first step, show the splash and then this error).
    /// TODO[Registration] define what this must contain.
    case showGenericError

    /// Special case, should display a banner on the current screen, whatever it is.
    /// Happens if we get a response from the server we can't parse; we assume this means
    /// an app version update is needed to parse it.
    /// (If this is returned as the first step, show the splash and then this error).
    case appUpdateBanner

    /// Special case; done with the registration flow!
    case done
}