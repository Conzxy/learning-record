# I don't want to use the builtin variable ${BUILD_SHARED_LIBS}
# since it you don't set it to ON explicitly, then the NOT 
# ${BUILD_SHARED_LIBS} will be false, and generated libraries 
# are static. That's not I wanted behavior. I want a variable,
# it can build shared libraries default even though I don't set 
# it explitly, and the build of static libraries is an option.
option(KANON_BUILD_STATIC_LIBS "Build kanon static libraries" OFF)

# After enable this option and build, you should type `cmake --install`
# to install files to proper destination actually.
option(KANON_INSTALL "Generate the install target" ${KANON_MAIN_PROJECT})
