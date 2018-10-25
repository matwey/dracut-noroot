#!/bin/bash

# called by dracut
check() {
	return 255
}

# called by dracut
depends() {
	return 0
}

# called by dracut
installkernel() {
	return 0
}

# called by dracut
install() {
	inst_hook cmdline 95 "${moddir}/parse-noroot.sh"

	ln -sf /dev/null "${initdir}${systemdsystemunitdir}/initrd-root-fs.target"
	ln -sf /dev/null "${initdir}${systemdsystemunitdir}/initrd-root-device.target"
	ln -sf /dev/null "${initdir}${systemdsystemunitdir}/initrd-fs.target"
	ln -sf /dev/null "${initdir}${systemdsystemunitdir}/initrd-parse-etc.service"

	inst_multiple -o \
		"${systemdsystemunitdir}/getty@.service" \
		"${systemdsystemunitdir}/serial-getty@.service" \
		"${systemdsystemunitdir}/getty.target" \
		"${systemdutildir}/system-generators/systemd-getty-generator"

	mkdir -p "${initdir}/${systemdsystemunitdir}/initrd.target.wants"
	ln_r "${systemdsystemunitdir}/getty.target" "$systemdsystemunitdir/initrd.target.wants"

	mkdir -p "${initdir}/${systemdsystemunitdir}/serial-getty@.service.d"
	inst "${moddir}/serial-getty.conf" "${systemdsystemunitdir}/serial-getty@.service.d/override.conf"

	mkdir -p "${initdir}/${systemdsystemunitdir}/getty@.service.d"
	inst "${moddir}/serial-getty.conf" "${systemdsystemunitdir}/getty@.service.d/override.conf"
	ln_r "${systemdsystemunitdir}/getty@.service" "$systemdsystemunitdir/initrd.target.wants/getty@tty1.service"
}
