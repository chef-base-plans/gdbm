pkg_name=gdbm
pkg_origin=core
pkg_version=1.22
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
GNU dbm is a set of database routines that use extensible hashing. It works \
similar to the standard UNIX dbm routines.\
"
pkg_upstream_url="http://www.gnu.org/software/gdbm/gdbm.html"
pkg_license=('gplv3+')
pkg_source="http://ftp.gnu.org/gnu/$pkg_name/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="f366c823a6724af313b6bbe975b2809f9a157e5f6a43612a72949138d161d762"
pkg_build_deps=(
  core/coreutils
  core/dejagnu
  core/diffutils
  core/gcc
  core/make
  core/patch
)
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-libgdbm-compat
  make
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # create symlinks for compatibility
  install -dm755 "$pkg_prefix/include/gdbm"
  ln -sf ../gdbm.h "$pkg_prefix/include/gdbm/gdbm.h"
  ln -sf ../ndbm.h "$pkg_prefix/include/gdbm/ndbm.h"
  ln -sf ../dbm.h  "$pkg_prefix/include/gdbm/dbm.h"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    core/gcc
    core/coreutils
  )
fi
