# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4} pypy )

inherit distutils-r1

MY_PN="textile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python port of Textile, A humane web text generator"
HOMEPAGE="https://github.com/textile/python-textile"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND="
	dev-python/regex[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# This resolves a nasty race condition, courtesy of Arfrever
	sed -e 's:with-id = 1::' -i setup.cfg || die
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests textile/tests/ || die "Tests failed under ${EPYTHON}"
}
