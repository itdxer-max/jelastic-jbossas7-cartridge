#!/bin/bash

WGET=$(which wget);

function _deploy(){
     local config="${OPENSHIFT_JBOSSAS_DIR}/versions/${Version}/standalone/configuration/standalone.xml"
     [ -f "$config" ] && grep -q "enable-welcome-root=\"true\"" "$config"  &&  { sed -i 's/enable-welcome-root=\"true\"/enable-welcome-root=\"false\"/g' "$config";
             SERVICE=$(which service);
             $SERVICE cartridge restart; ### require for apply new standalone.xml config
     }     
     [ "x${context}" == "xroot" ] && context="ROOT";
     [ -f "${WEBROOT}/${context}.war" ] && rm -f ${WEBROOT}/${context}.war;
     [ -f "${WEBROOT}/${context}.war.undeployed" ] && mv ${WEBROOT}/${context}.war.undeployed ${WEBROOT}/${context}.war.deployed
     $WGET --no-check-certificate --content-disposition -O "${WEBROOT}/${context}.war" "$package_url";
}

function _undeploy(){
     [ "x${context}" == "xroot" ] && context="ROOT";
     [ -f "${WEBROOT}/${context}.war" ] &&  rm -f ${WEBROOT}/${context}.war || return 0;
}
