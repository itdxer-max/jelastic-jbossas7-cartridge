#!/bin/bash

WGET=$(which wget);

function _deploy(){
     [ "x${context}" == "xroot" ] && context="ROOT";
     [ -f "${WEBROOT}/${context}.war" ] && rm -f ${WEBROOT}/${context}.war;
     [ -f "${WEBROOT}/${context}.war.undeployed" ] && mv ${WEBROOT}/${context}.war.undeployed ${WEBROOT}/${context}.war.deployed
     $WGET --no-check-certificate --content-disposition -O "${WEBROOT}/${context}.war" "$package_url";
}

function _undeploy(){
     [ "x${context}" == "xroot" ] && context="ROOT";
     [ -f "${WEBROOT}/${context}.war" ] &&  rm -f ${WEBROOT}/${context}.war || return 0;
}
