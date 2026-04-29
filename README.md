## Architecture

The SDK follows Clean Architecture where it adds value, not as a ritual. The Consent feature has three layers because it has genuine business logic (when to show the dialog, treating rejection as final) and persistence to abstract.
The Rewarded feature only has a Presenter. There is no business rule worth extracting and no state to persist: adding Data/Domain layers would be ceremony without new abstractions.

## Testing

There are unit tests for ConsentInteractor that's where the business rules live (when to show the dialog, "rejection is final"). The tests use a small spy for the storage so they don't touch UserDefaults. 

## Documentation
Implemented

## Logging

Internal logging uses the **Facade pattern**. RewardSDKLogger exposes a single log(_:level:) method to the rest of the SDK and fans each call out to multiple LogSink implementations in parallel:

```swift
internal final class RewardSDKLogger {
    private let sinks: [LogSink]

    func log(_ message: String, level: LogLevel) {
        sinks.forEach { $0.write(message, level: level) }
    }
}
```

This makes it possible to ship logs to several analytics/observability systems simultaneously from a single call site.

```markdown
## Logging

Internal logging uses the **Facade pattern**. `RewardSDKLogger` exposes a single `log(_:level:)` method to the rest of the SDK and fans each call out to multiple `LogSink` implementations in parallel:

```swift
internal final class RewardSDKLogger {
    private let sinks: [LogSink]

    func log(_ message: String, level: LogLevel) {
        sinks.forEach { $0.write(message, level: level) }
    }
}
```

I added two kinds of sinks:

- **Local logs** via OSLogSink — writes to Apple's unified logging, persisted by the OS and visible in `Console.app` or `log show`. Useful for the developer integrating the SDK to debug locally.
- **Production telemetry** via SentrySink — not fully implemented, but in the future could POST events to a custom endpoint that forwards them to Sentry, avoiding having to integrate the Sentry SDK as a dependency.

This makes it possible to ship logs to several analytics or observability systems simultaneously from a single call site.


## Compatibility

The SDK is Swift-only.


## Requirement clarification

I would clarify two ambiguities in the brief before locking the design:

**What "event tracking" persistence means.** The brief lists *"Consent and event tracking must persist across app launches"* under the persistence guideline, but the per-feature requirements only describe a callback for the rewarded view, not events to track. Possible readings:

- The consent decision is itself the *event* being tracked (what I implemented).
- Reward-related counters (shown / claimed) should be persisted.
- A more general analytics pipeline is expected.

The choice changes whether `RewardedManager` needs Data/Domain layers (counters) or stays presentation-only (callback). I went with the first reading and kept Rewarded thin, but this is the call I would most want to verify.

**What kind of data the consent governs.** The brief asks for a generic privacy dialog, but the implementation differs depending on the data scope:

- **Analytics or non-sensitive data** — a custom in-app dialog (what I implemented) is appropriate, persisted in UserDefaults.
- **Cross-app tracking with IDFA** — the consent should be Apple's ATTrackingManager.requestTrackingAuthorization, paired with NSUserTrackingUsageDescription in Info.plist. The system itself shows the dialog and persists the choice; a custom one is not appropriate.
