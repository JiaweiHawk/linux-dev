#!/bin/bash
set -e
set -x

usage() {
        echo "Usage:"
        echo "        $0 <gdb port> <ssh port> <kernel path> <image path> <destination path>"
}

if [[ $# != 5 ]]; then
        usage
        exit 1
fi

gdb=$1
ssh=$2
kernel="$3"
image="$4"
path="$5"
smp=1

# set the Makefile
# content of the Makefile
#
#
#ifeq ($(GDB_PORT), )
#        GDB_PORT=1234
#endif
#
#ifeq ($(SSH_PORT), )
#        SSH_PORT=1235
#endif
#
#ifeq ($(KERNEL), )
#        KERNEL=/home/hawk/Desktop/linux
#endif
#
#ifeq ($(SMP), )
#        SMP=1
#endif
#
#ifeq ($(IMAGE), )
#        IMAGE=/home/hawk/Desktop/syzbot/image/stretch.img
#endif
#
#ndebug:
#	qemu-system-x86_64 -smp ${SMP} -m 8G -enable-kvm -cpu host \
#                -net nic \
#                -net user,hostfwd=tcp::${SSH_PORT}-:22 \
#                -kernel ${KERNEL}/arch/x86_64/boot/bzImage \
#                -drive file=${IMAGE},format=raw,media=disk \
#                -append "root=/dev/sda console=ttyS0 earlyprintk=serial nokaslr" \
#                -nographic \
#                --no-reboot --no-shutdown
#
#debug:
#	qemu-system-x86_64 -smp ${SMP} -m 8G -enable-kvm -cpu host \
#                -net nic \
#                -net user,hostfwd=tcp::${SSH_PORT}-:22 \
#                -kernel ${KERNEL}/arch/x86_64/boot/bzImage \
#                -drive file=${IMAGE},format=raw,media=disk \
#                -append "root=/dev/sda console=ttyS0 earlyprintk=serial nokaslr" \
#                -nographic \
#                --no-reboot --no-shutdown \
#                -S -gdb tcp::${GDB_PORT}
#
#gdbinit:
#	echo -n '' > .gdbinit
#	echo 'target remote localhost:${GDB_PORT}' >> .gdbinit
#
#gdb: gdbinit
#	gdb ${KERNEL}/vmlinux
#
#
echo -n ''                                                                                 > ${path}/Makefile
echo 'ifeq ($(GDB_PORT), )'                                                               >> ${path}/Makefile
echo '        GDB_PORT='"${gdb}"                                                          >> ${path}/Makefile
echo 'endif'                                                                              >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'ifeq ($(SSH_PORT), )'                                                               >> ${path}/Makefile
echo '        SSH_PORT='"${ssh}"                                                          >> ${path}/Makefile
echo 'endif'                                                                              >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'ifeq ($(KERNEL), )'                                                                 >> ${path}/Makefile
echo '        KERNEL='"${kernel}"                                                         >> ${path}/Makefile
echo 'endif'                                                                              >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'ifeq ($(SMP), )'                                                                    >> ${path}/Makefile
echo '        SMP='"${smp}"                                                               >> ${path}/Makefile
echo 'endif'                                                                              >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'ifeq ($(IMAGE), )'                                                                  >> ${path}/Makefile
echo '        IMAGE='"${image}"                                                           >> ${path}/Makefile
echo 'endif'                                                                              >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'ndebug:'                                                                            >> ${path}/Makefile
echo -e '\tqemu-system-x86_64 -smp ${SMP} -m 8G -enable-kvm -cpu host \'                  >> ${path}/Makefile
echo '                -net nic \'                                                         >> ${path}/Makefile
echo '                -net user,hostfwd=tcp::${SSH_PORT}-:22 \'                           >> ${path}/Makefile
echo '                -kernel ${KERNEL}/arch/x86_64/boot/bzImage \'                       >> ${path}/Makefile
echo '                -drive file=${IMAGE},format=raw,media=disk \'                       >> ${path}/Makefile
echo '                -append "root=/dev/sda console=ttyS0 earlyprintk=serial nokaslr" \' >> ${path}/Makefile
echo '                -nographic \'                                                       >> ${path}/Makefile
echo '                --no-reboot --no-shutdown'                                          >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'debug:'                                                                             >> ${path}/Makefile
echo -e '\tqemu-system-x86_64 -smp ${SMP} -m 8G -enable-kvm -cpu host \'                  >> ${path}/Makefile
echo '                -net nic \'                                                         >> ${path}/Makefile
echo '                -net user,hostfwd=tcp::${SSH_PORT}-:22 \'                           >> ${path}/Makefile
echo '                -kernel ${KERNEL}/arch/x86_64/boot/bzImage \'                       >> ${path}/Makefile
echo '                -drive file=${IMAGE},format=raw,media=disk \'                       >> ${path}/Makefile
echo '                -append "root=/dev/sda console=ttyS0 earlyprintk=serial nokaslr" \' >> ${path}/Makefile
echo '                -nographic \'                                                       >> ${path}/Makefile
echo '                --no-reboot --no-shutdown \'                                        >> ${path}/Makefile
echo '                -S -gdb tcp::${GDB_PORT}'                                           >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'gdbinit:'                                                                           >> ${path}/Makefile
echo -e '\techo -n '"'""'"' > .gdbinit'                                                   >> ${path}/Makefile
echo -e '\techo '"'"'target remote localhost:${GDB_PORT}'"'"' >> .gdbinit'                >> ${path}/Makefile
echo ''                                                                                   >> ${path}/Makefile
echo 'gdb: gdbinit'                                                                       >> ${path}/Makefile
echo -e '\tgdb ${KERNEL}/vmlinux'                                                         >> ${path}/Makefile
