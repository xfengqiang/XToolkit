cd ..
projectdir=$(pwd)
echo ${projectdir}
projectname=`basename ${projectdir}`
echo ${projectname}

srcdir="${projectname}/Frameworks/Headers"
echo ${srcdir}
libsdir="${projectname}/Frameworks/Libs"
echo ${libsdir}

cd ..

curdir=$(pwd)
function build()
{
   pwd
   echo $1;
   echo $3;
   if [ -f $1/Build/build.sh ];then
	echo "found $1/Build/build.sh"
	cd $1/Build
        libBuildDir=$(pwd)
	./build.sh $3 $4
	cd "${projectdir}"
	if [ -d "${srcdir}/$2" ];then
	   find "${srcdir}/$2" -name "*.h" |xargs rm
	fi
        cp "${libBuildDir}/lib$2.a" "${libsdir}/"
        cp "${libBuildDir}/lib$2_release.a" "${libsdir}/"
	cp -fr "${libBuildDir}/Headers/$2" "${srcdir}/"
   else
	echo "not found $1/Build/build.sh"
   fi
   cd "${curdir}"
}

function usage()
{
echo "command error:"
echo "this command needs 1 parameters at least"
echo "first paramenter:  -core -3rd -ui -appCore or -a"
echo "last parameter is -c, this paramenter is optional"
echo "-core      build XToolkitCore"
echo "-3rd      bulld XToolkit3rd"
echo "-ui      build XToolkitUI"
echo "-appCore      build appCore"
}

if ( test $# -lt 1 ); then
usage
else
if ( [ "$1" = "-a" ] || [ "$1" = "-core" ]);then
build "XToolkitCore" "XToolkitCore" $2 $3
fi

if ( [ "$1" = "-a" ] || [ "$1" = "-3rd" ] );then
build "XToolkit3rd" "XToolkit3rd"   $2  $3
fi

if ( [ "$1" = "-a" ] || [ "$1" = "-ui" ]);then
build "XToolkitUI" "XToolkitUI" $2 $3
fi

fi
