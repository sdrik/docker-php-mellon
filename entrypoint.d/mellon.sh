[ -n "${SAML_SP_ENTITYID}" ] || return

apache_mods+=(+auth_mellon)
apache_confs+=(+mellon)

export SAML_SP_KEY=${SAML_SP_KEY:-/samldata/sp.key}
export SAML_SP_KEY_ALG=${SAML_SP_KEY_ALG:-rsa:4096}

export SAML_SP_CERT=${SAML_SP_CERT:-/samldata/sp.crt}
export SAML_SP_CERT_DAYS=${SAML_SP_CERT_DAYS:-3650}
export SAML_SP_CERT_SUBJECT=${SAML_SP_CERT_SUBJECT:-/C=FR/ST=/L=/O=/CN=example.com}
export SAML_SP_CERT_DIGEST=${SAML_SP_CERT_DIGEST:-sha256}

export SAML_GLOBAL_ENABLE=${SAML_GLOBAL_ENABLE:-off}
export SAML_ENDPOINT=${SAML_ENDPOINT:-/saml}
export SAML_IDP_METADATA=${SAML_IDP_METADATA:-/samldata/metadata/*.xml}

[ -f ${SAML_SP_CERT} ] && [ -f ${SAML_SP_KEY} ] && return

mkdir -p $(dirname ${SAML_SP_CERT}) $(dirname ${SAML_SP_KEY})
openssl req -x509 -${SAML_SP_CERT_DIGEST} -nodes -days ${SAML_SP_CERT_DAYS} -newkey ${SAML_SP_KEY_ALG} -keyout ${SAML_SP_KEY} -out ${SAML_SP_CERT} -subj "${SAML_SP_CERT_SUBJECT}"
