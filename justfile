# Update all packages across dnf, flatpak, and snap
default: update

# Run all updates
update: update-dnf update-flatpak update-snap
    @echo "✅ All updates complete!"

# Check for available updates across all package managers + firmware
check: check-dnf check-flatpak check-snap check-firmware
    @echo "✅ Update check complete!"

# Update system packages via dnf
update-dnf:
    @echo "📦 Updating dnf packages..."
    sudo dnf upgrade --refresh -y

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
    dnf check-update || true

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
