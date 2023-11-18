project "Authenticator"
	kind "ConsoleApp"
	language "C++"

	targetdir (solutionDir .. "/bin/" .. outputdir .. "/%{prj.name}")
	objdir (solutionDir .. "/bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "pch.h"
	pchsource "src/pch.cpp" 

	files {
		"src/**.h",
		"src/**.cpp"
	}

	includedirs {
		"src",
		solutionDir .. "%{includeDirs.SPDLOG}",
		solutionDir .. "%{includeDirs.MYSQL}",
		solutionDir .. "%{includeDirs.TWONET}"
	}

	libdirs {
		solutionDir .. "%{libraryDirs.MYSQL}",
		solutionDir .. "%{libraryDirs.TWONET}"
	}

	links {
		"mysqlcppconn",
		"ws2_32.lib",
		"TwoNet.lib"
	}


	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		staticruntime "on"

		defines {
		}

		postbuildcommands {
		}


	filter "configurations:Debug"
		defines {
			"TWONET_DEBUG",
			"TWONET_ASSERT_ENABLED"	
		}
		symbols "On"
		staticruntime "off"

		prebuildcommands {
			("{COPY} vendor/MYSQL/" .. outputdir .. "/lib64/mysqlcppconn-9-vs14.dll " .. solutionDir .. "bin/" .. outputdir .. "/%{prj.name}")
		}

	filter "configurations:Release"
		defines "TWONET_RELEASE"
		optimize "On"

		prebuildcommands {
			("{COPY} vendor/MYSQL/" .. outputdir .. "/lib64/mysqlcppconn-9-vs14.dll " .. solutionDir .. "bin/" .. outputdir .. "/%{prj.name}"),
			("{COPY} vendor/MYSQL/" .. outputdir .. "/lib64/libcrypto-1_1-x64.dll " .. solutionDir .. "bin/" .. outputdir .. "/%{prj.name}"),
			("{COPY} vendor/MYSQL/" .. outputdir .. "/lib64/libssl-1_1-x64.dll " .. solutionDir .. "bin/" .. outputdir .. "/%{prj.name}")
		}

	filter "configurations:Dist"
		defines "TWONET_DIST"
		optimize "On"
	
