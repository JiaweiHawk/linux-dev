#!/bin/bash
set -e
set -x

usage() {
        echo "Usage:"
        echo "        $0 <git name> <git email> <gmail password> <linux source code path>"
}

if [[ $# != 4 ]]; then
        usage
        exit 1
fi

port=587
name="$1"
email="$2"
password="$3"
path="$4"

# install msmtp
sudo apt-get update
sudo apt-get install msmtp

# set git config
(cd ${path}; git config --local user.name "${name}")
(cd ${path}; git config --local user.email "${email}")
(cd ${path}; git config --local format.signoff "true")
(cd ${path}; git config --local sendemail.smtpencryption "tls")
(cd ${path}; git config --local sendemail.smtpserver "$(whereis msmtp | awk '{print $2}')")
(cd ${path}; git config --local sendemail.smtpserverport "${port}")
(cd ${path}; git config --local sendemail.tocmd "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol")
(cd ${path}; git config --local sendemail.cccmd "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom")

# set msmtp config
# content of ~/.msmtprc
#
#        defaults
#        auth                      on
#        tls                       on
#        tls_starttls              on
#        tls_trust_file            /etc/ssl/certs/ca-certificates.crt
#        logfile                   ~/.msmtp.log
#
#        #Gmail Account:
#        account                   gmail
#        host                      smtp.gmail.com
#        port                      ${port}
#        from                      ${email}
#        user                      ${email}
#        password                  ${password}
#
#        # Set a default account:
#        account default :         gmail
#
echo -n ''                                                               >  ~/.msmtprc
echo 'defaults'                                                          >> ~/.msmtprc
echo 'auth                      on'                                      >> ~/.msmtprc
echo 'tls                       on'                                      >> ~/.msmtprc
echo 'tls_starttls              on'                                      >> ~/.msmtprc
echo 'tls_trust_file            /etc/ssl/certs/ca-certificates.crt'      >> ~/.msmtprc
echo 'logfile                   ~/.msmtp.log'                            >> ~/.msmtprc
echo ''                                                                  >> ~/.msmtprc
echo '#Gmail Account:'                                                   >> ~/.msmtprc
echo 'account                   gmail'                                   >> ~/.msmtprc
echo 'host                      smtp.gmail.com'                          >> ~/.msmtprc
echo 'port                      '"${port}"                               >> ~/.msmtprc
echo 'from                      '"${email}"                              >> ~/.msmtprc
echo 'user                      '"${email}"                              >> ~/.msmtprc
echo 'password                  '"${password}"                           >> ~/.msmtprc
echo ''                                                                  >> ~/.msmtprc
echo '# Set a default account:'                                          >> ~/.msmtprc
echo 'account default :         gmail'                                   >> ~/.msmtprc
