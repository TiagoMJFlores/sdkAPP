# ``RewardSDK``


A lightweight iOS SDK distributed as a framework target inside the Mastermind app. Provides two independent features:

- **Rewarded** — show a sheet with a "Claim Reward" button and receive a callback when the user claims it.
- **Consent** — show a privacy dialog at app launch and persist the user's decision across launches.

## Documentation

- [Integration](docs/Integration.md) — adding `RewardSDK` to a host app
- [Consent](docs/Consent.md) — collecting and reading user consent
- [Rewarded](docs/Rewarded.md) — presenting the rewarded view and handling claims

## Public API at a glance

```swift
