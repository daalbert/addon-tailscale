#!/command/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Home Assistant Community Add-on: Tailscale
# S6 Overlay stage2 hook to customize services
# ==============================================================================

# Disable protect-subnets service when userspace-networking is enabled
# Disable mss-clamping service when userspace-networking is enabled
if ! bashio::config.has_value "userspace_networking" || \
    bashio::config.true "userspace_networking";
then
    rm /etc/s6-overlay/s6-rc.d/user/contents.d/protect-subnets
    rm /etc/s6-overlay/s6-rc.d/post-tailscaled/dependencies.d/protect-subnets

    rm /etc/s6-overlay/s6-rc.d/user/contents.d/mss-clamping
fi

# Disable taildrop service when it is has been explicitly disabled
if bashio::config.false 'taildrop'; then
    rm /etc/s6-overlay/s6-rc.d/user/contents.d/taildrop
fi
