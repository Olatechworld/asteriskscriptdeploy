#!/bin/bash
#MES VARIABLES POUR L INSTALL
echo "Deplacer vous dans le dossier /usr/local/src"
echo "Assurez vous que wget soit bien installé, par défaut c/'est pas installé dans Centos7"
echo "La version doit être sous la forme xx.x.x. pour plus d'infos  rendez vous sur le site de téléchargement de asterisk"
Dowload_Source="wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-$1.tar.gz"
Untarring_Source="tar -zxvf asterisk-$1.tar.gz"
Asterisk_directory="cd /usr/local/src/asterisk-$1/"
Configure="./configure --with-jansson-bundled"


function Config_Asterisk(){
    sleep 5
    ./configure
    cd contrib/scripts
    echo "Les pacquets suivants vont être installés sur votre système"
    ./install_prereq test
    sleep 7
    ./install_prereq install
    ./install_prereq install-unpackaged
    echo " Retour dans le Répértoire d'Asterisk"
    sleep 5
    $Asterisk_directory
    $Configure
    make
    make install
    make samples
    make config
    make install-logrotate
}

function Deploy_Asterisk(){
    $Dowload_Source
    echo "Décommpression"
    sleep 5
    $Untarring_Source
    echo "Changement de répertoire vers le dossier Asterisk..........."
    sleep 5
    $Asterisk_directory
    Config_Asterisk
    if(($?==0))
    then
        echo "l'installation est terminé avec succès=>Merci"
    fi
}
Deploy_Asterisk
