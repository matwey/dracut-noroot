# dracut-noroot

[dracut](https://github.com/dracutdevs/dracut) module to allow lightweight live Linux systems.

When this module is enabled, dracut opens bash shell instead of mounting `root=` and proceeding to normal boot.
It may be useful to deploy the kernel by PXE during Linux Kernel developing or hardware testing.
