# Update all packages across dnf, flatpak, and snap
default: update

# Run all updates
update: update-dnf update-flatpak
    @echo "✅ All updates complete!"

# Check for available updates across all package managers + firmware
check: check-dnf check-flatpak check-firmware
    @echo "✅ Update check complete!"

# Update system packages via dnf
update-dnf:
    @echo "📦 Updating dnf packages..."
    sudo dnf upgrade -y

# Update Flatpak apps
update-flatpak:
    @echo "📦 Updating Flatpak apps..."
    flatpak update -y

# Update Snap packages
update-snap:
    @echo "📦 Updating Snap packages..."
    sudo snap refresh

# Update firmware via fwupd
update-firmware:
    @echo "🔧 Updating firmware..."
    sudo fwupdmgr update

# Check for available dnf updates
check-dnf:
    @echo "📦 Available dnf updates:"
    sudo dnf check-update --refresh || true

# Check for available Flatpak updates
check-flatpak:
    @echo "📦 Available Flatpak updates:"
    flatpak remote-ls --updates

# Check for available Snap updates
check-snap:
    @echo "📦 Available Snap updates:"
    snap refresh --list

# Check for available firmware updates
check-firmware:
    @echo "🔧 Available firmware updates:"
    fwupdmgr get-updates || true

# Install the latest tidal-hifi RPM from GitHub
update-tidal-hifi:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "🎵 Fetching latest tidal-hifi release..."
    rpm_url=$(curl -sL https://api.github.com/repos/Mastermindzh/tidal-hifi/releases/latest \
        | grep -oP '"browser_download_url"\s*:\s*"\K[^"]+\.x86_64\.rpm')
    echo "⬇️  Downloading $rpm_url"
    tmp=$(mktemp --suffix=.rpm)
    curl -L -o "$tmp" "$rpm_url"
    echo "📦 Installing..."
    sudo dnf install -y "$tmp"
    rm -f "$tmp"
    echo "✅ tidal-hifi updated!"

# Download and install the latest Proton-GE for Steam
update-proton-ge:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "🎮 Fetching latest Proton-GE release..."
    rm -rf /tmp/proton-ge-custom
    mkdir /tmp/proton-ge-custom
    cd /tmp/proton-ge-custom
    tarball_url=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
        | grep browser_download_url | cut -d\" -f4 | grep .tar.gz)
    tarball_name=$(basename "$tarball_url")
    echo "⬇️  Downloading $tarball_name..."
    curl -# -L "$tarball_url" -o "$tarball_name" --no-progress-meter
    checksum_url=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
        | grep browser_download_url | cut -d\" -f4 | grep .sha512sum)
    checksum_name=$(basename "$checksum_url")
    echo "⬇️  Downloading checksum..."
    curl -# -L "$checksum_url" -o "$checksum_name" --no-progress-meter
    echo "🔍 Verifying checksum..."
    sha512sum -c "$checksum_name"
    mkdir -p ~/.steam/steam/compatibilitytools.d
    echo "📦 Extracting to Steam compatibility tools..."
    tar -xf "$tarball_name" -C ~/.steam/steam/compatibilitytools.d/
    rm -rf /tmp/proton-ge-custom
    echo "🧹 Removing old Proton-GE versions (keeping 3 newest)..."
    cd ~/.steam/steam/compatibilitytools.d
    ls -dt GE-Proton* 2>/dev/null | tail -n +4 | xargs -r rm -rf
    echo "✅ Proton-GE updated!"
