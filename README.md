# mIOU — macOS Onboarding (Intune + SwiftDialog + Baseline)

Welcome to **mIOU** — an automated, reliable onboarding experience for macOS devices managed with Microsoft Intune. mIOU brings together proven community tools to prepare your Mac, install essential apps, and apply required configuration—fast—so you can get working with minimal friction.

> **At a glance**
> - Streamlined macOS onboarding via **Intune**
> - Friendly progress UI with **SwiftDialog**
> - Robust app installation handled by **Installomator**
> - Standards‑based baseline configuration powered by a custom implementation of **Second Son Consulting’s Baseline**

---

## What you can expect (End‑User Guide)

### Before you begin
- **Power & Network**: Plug in your Mac and connect to a stable network (corporate Wi‑Fi or Ethernet).
- **Time needed**: ~15–30 minutes depending on your model and internet speed.
- **Keep working**: You can continue light tasks; the installer may prompt you a few times.

### The onboarding flow
1. **Kick‑off**  
   Your device receives an onboarding package from Intune. A small setup script ensures all prerequisites are present (no action required from you).

2. **Friendly progress screen**  
   A SwiftDialog window appears with your organization’s banner and status updates (e.g., “Installing apps…”, “Applying settings…”).

3. **Apps install automatically**  
   Core apps are downloaded and installed by Installomator. You might see app icons appear in Launchpad/Dock.

4. **Device configuration applied**  
   Required macOS settings and management profiles are applied to keep your device secure and compliant.

5. **Wrap‑up**  
   When everything is complete, the dialog confirms success. If anything requires attention (rare), you’ll see a clear message with next steps.

### Prompts you may see
- **System permissions** (e.g., notifications, screen recording for conferencing tools)
- **Security approvals** (e.g., allowing management profiles or enabling system extensions)
- **Reboots** (only if required; you’ll be warned beforehand)

> **Tip:** Always click **Allow/Approve** when prompted for company‑managed apps or profiles during onboarding.

---

## After onboarding

- Your Mac is **managed by Intune** and compliant with corporate policies.
- Core applications are installed and ready to use.
- If you configured your Dock, it should show only the apps you want.
- You can open **Company Portal** to see assigned apps or run a device compliance check anytime.


---

## How mIOU works (High‑Level)

mIOU automates the three core tasks of Mac onboarding:

1. **Prerequisite bootstrap (Intune‑delivered script)**  
   A lightweight Bash script runs first to fetch toolings and pre‑requirements dependably before the full onboarding begins.

2. **Guided experience (SwiftDialog)**  
   Users see a clean, branded progress UI with status messages while apps install and configurations apply.

3. **Apps & baseline (Installomator + Baseline)**  
   Installomator handles app installations reliably; the Baseline–derived configuration sets secure defaults and enables management.

No manual steps are required from end‑users beyond approving normal macOS security prompts when asked.

---

## For IT Admins

> **Components overview**
- **Second Son’s Baseline (custom implementation)**  
  Provides the opinionated configuration baseline and orchestration.
- **SwiftDialog**  
  Presents user‑friendly status/progress.
- **Installomator**  
  Robust app installer (handles downloads, versions, receipts).

> **Why a Bash script?**  
> Delivering a single, predictable bootstrap step via Intune proved the quickest and most reliable way to put the required tools on devices before running the full onboarding flow.

### `SECT/` folder contents
- **`Banner/`** - Branded banner image used by SwiftDialog (replace with your organization’s image).
- **`Configuration/`** - Contains the `.mobileconfig` to upload to Intune and push to devices.  
  > You can edit this in **iMazing Profile Editor** to tailor payloads (Wi‑Fi, certs, privacy, etc.) before export.
- **`icons/`** - Application icons displayed during onboarding (keeps the dialog consistent with your app set).
- **`scripts/`** - Numbered onboarding scripts for clear ordering/tracking.

> **Recommended workflow**
1. **Customize** your banner and icons to reflect branding.  
2. **Edit** the `.mobileconfig` with iMazing Profile Editor (payloads, identifiers, scopes).  
3. **Upload** the `.mobileconfig` to Intune (macOS → Configuration profiles → Custom) and **assign** to target groups.  
4. **Deploy** the bootstrap Bash script via Intune device scripts (macOS → Shell script) with appropriate run context, frequency, and retry settings.  
5. **Validate** on a test device (network, app install success, profile application, compliance).  
6. **Roll out** to production groups with phased rings if needed.

---

## Frequently asked (Admins)

**Do you support this product?**  
No, this is provided to the community as is, although as it is based on well-known and very active Open Source projects such as Baseline, SwiftDialog and Installomator, you can find additional information from those projects and online.

**How do I add another app?**  
Add its icon to `icons/`, update the relevant `scripts/<nn>-install-*.sh` with a script to deploy that app or an Installomator label to the Configuration .mobileconfig file. Remember you will need to update the .mobileconfig file in Intune as well.

**Do I need to repackage for every change?**  
Minor script or profile updates can be pushed via Intune without repackaging the entire flow; keep versions aligned and test on pilot devices.

---



---

## License

MIT

---

## Credits

- **SwiftDialog** and **Installomator** — open‑source community projects that make macOS onboarding both friendly and reliable.
- **Second Son Consulting’s Baseline** — foundational baseline approach adapted for this implementation.