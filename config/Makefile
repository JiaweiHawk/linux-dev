ifeq ($(GDB_PORT), )
        GDB_PORT=1234
endif

ifeq ($(SSH_PORT), )
        SSH_PORT=1235
endif

ifeq ($(KERNEL), )
        KERNEL=linux
endif

ifeq ($(SMP), )
        SMP=1
endif

ifeq ($(IMAGE), )
        IMAGE=image
endif

ndebug:
	qemu-system-x86_64 -smp ${SMP} -m 8G -enable-kvm -cpu host \
                -net nic \
                -net user,hostfwd=tcp::${SSH_PORT}-:22 \
                -kernel ${KERNEL}/arch/x86_64/boot/bzImage \
                -drive file=${IMAGE},format=raw,media=disk \
                -append "root=/dev/sda console=ttyS0 earlyprintk=serial nokaslr" \
                -nographic \
                --no-reboot --no-shutdown

debug:
	qemu-system-x86_64 -smp ${SMP} -m 8G -enable-kvm -cpu host \
                -net nic \
                -net user,hostfwd=tcp::${SSH_PORT}-:22 \
                -kernel ${KERNEL}/arch/x86_64/boot/bzImage \
                -drive file=${IMAGE},format=raw,media=disk \
                -append "root=/dev/sda console=ttyS0 earlyprintk=serial nokaslr" \
                -nographic \
                --no-reboot --no-shutdown \
                -S -gdb tcp::${GDB_PORT}

gdbinit:
	echo -n '' > .gdbinit
	echo 'target remote localhost:${GDB_PORT}' >> .gdbinit

gdb: gdbinit
	gdb ${KERNEL}/vmlinux
