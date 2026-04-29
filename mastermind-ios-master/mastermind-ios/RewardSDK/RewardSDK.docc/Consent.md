

## Consent

Show a privacy dialog the first time the app launches, persist the user's decision, and skip the dialog on subsequent launches.

## API

```swift
public protocol ConsentManagerProtocol {
    func showConsentDialog()
    func getConsentStatus() -> Bool?
}

public func makeConsentManager(config: ConsentDialogConfig = .default) -> ConsentManager

public extension View {
    func consentHost(_ manager: ConsentManager) -> some View
}
```

## Behaviour

- `showConsentDialog()` is a no-op if the user has already decided.
- `getConsentStatus()` returns:
  - `nil` — no decision yet
  - `true` — user consented
  - `false` — user declined
- The decision is persisted in `UserDefaults` and survives app restarts.
- A rejection is treated as a final decision (the dialog is not shown again).

## Usage

Create the manager at the app level so a single instance lives for the whole session:

```swift
import SwiftUI
import RewardSDK

@main
struct MyApp: App {
    @StateObject private var consent = makeConsentManager()

    var body: some Scene {
        WindowGroup {
            ContentView(consentManager: consent)
        }
    }
}
```

In your root view, attach `consentHost` and trigger the dialog when there is no prior decision:

```swift
struct ContentView: View {
    @ObservedObject var consentManager: ConsentManager

    var body: some View {
        SomeContent()
            .consentHost(consentManager)
            .onAppear {
                if consentManager.getConsentStatus() == nil {
                    consentManager.showConsentDialog()
                }
            }
    }
}
```

## Reading the status later

You can call `getConsentStatus()` anywhere in the app to gate behaviour:

```swift
if consent.getConsentStatus() == true {
    enableAnalytics()
}
```

