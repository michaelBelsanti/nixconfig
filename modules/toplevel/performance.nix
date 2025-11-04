{
  unify.modules = {
    workstation.nixos.boot.kernelParams = [
      "nowatchdog"
      "nosoftlockup"
      "audit=0"
      "skew_tick=1"
      "threadirqs"
      "preempt=full"
      "nohz_full=all"
    ];
    desktop.nixos.boot.kernelParams = [
      "usbcore.autosuspend=60"
      "workqueue.power_efficient=false"
      "cpufreq.default_governor=performance"
    ];
  };
}
