################################################################################
#
# perl-xml-libxml
#
################################################################################

PERL_XML_LIBXML_VERSION = 2.0134
PERL_XML_LIBXML_SOURCE = XML-LibXML-$(PERL_XML_LIBXML_VERSION).tar.gz
PERL_XML_LIBXML_SITE = $(BR2_CPAN_MIRROR)/authors/id/S/SH/SHLOMIF
PERL_XML_LIBXML_DEPENDENCIES = zlib libxml2
PERL_XML_LIBXML_LICENSE = Artistic or GPL-1.0+
PERL_XML_LIBXML_LICENSE_FILES = LICENSE
PERL_XML_LIBXML_DISTNAME = XML-LibXML

PERL_XML_LIBXML_CONF_OPTS = \
	LIBS="-L $(STAGING_DIR)/usr/lib" \
	INC="-I $(STAGING_DIR)/usr/include/libxml2" \
	NO_THREADS

HOST_PERL_XML_LIBXML_DEPENDENCIES = host-libxml2
$(eval $(perl-package))
$(eval $(host-perl-package))
