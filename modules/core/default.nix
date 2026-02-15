{ config, lib, pkgs, ... }:

with lib;

{
  options.cupcake = {
    system.performance.enable = mkEnableOption "performance tweaks";
    system.security.enable = mkEnableOption "security hardening";
  };

  config = mkMerge [
    # --- Performance Tweaks ---
    (mkIf config.cupcake.system.performance.enable {
      boot.kernel.sysctl = {
        "vm.swappiness" = 10;
        "net.core.rmem_max" = 16777216;
        "net.core.wmem_max" = 16777216;
      };

      # Use performance-oriented I/O scheduler
      services.udev.extraRules = ''
        ACTION=="add|change", KERNEL=="sd[a-z]*|nvme[0-9]*", ATTR{queue/scheduler}="mq-deadline"
      '';
    })

    # --- Security Hardening ---
    (mkIf config.cupcake.system.security.enable {
      # Firewall
      networking.firewall.enable = true;
      networking.firewall.allowPing = false;

      # Restrict kernel info
      boot.kernel.sysctl = {
        "kernel.kptr_restrict" = 2;
        "kernel.dmesg_restrict" = 1;
        "net.ipv4.conf.all.rp_filter" = 1;
        "net.ipv4.conf.default.rp_filter" = 1;
      };

      # Sudo audit
      security.sudo.extraConfig = ''
        Defaults logfile="/var/log/sudo"
      '';
    })

    # --- Bootloader (Always applied, independent of features) ---
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
    }
  ];
}
